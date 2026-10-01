"""Check that the configured model can call a tool and return structured output.

Run with `make model-smoke`.
"""

import asyncio
import json
import secrets
import sys
import time

from agents import Agent, RunConfig, Runner, ToolCallItem, function_tool, set_default_openai_key, set_tracing_disabled
from pydantic import BaseModel

from .config import Settings

REFERENCE_ID = "smoke-check:1"


class SmokeResult(BaseModel):
    value: str
    evidence_refs: list[str]


async def run(settings: Settings) -> int:
    set_tracing_disabled(True)
    set_default_openai_key(settings.openai_api_key.get_secret_value(), use_for_tracing=False)

    # Random per run, so the model can only return it by calling the tool.
    expected_value = secrets.token_hex(4)

    @function_tool
    def get_reference_value() -> dict[str, str]:
        """Return the reference value and its ID."""
        return {"ref": REFERENCE_ID, "value": expected_value}

    agent = Agent(
        name="smoke-check",
        instructions="Call get_reference_value, then return its value and cite its ref in evidence_refs.",
        tools=[get_reference_value],
        output_type=SmokeResult,
        model=settings.openai_model,
    )
    started = time.monotonic()
    result = await asyncio.wait_for(
        Runner.run(
            agent,
            "What is the reference value?",
            max_turns=settings.agent_max_turns,
            run_config=RunConfig(tracing_disabled=True),
        ),
        timeout=settings.agent_timeout_seconds,
    )
    output = result.final_output
    usage = result.context_wrapper.usage
    structured = isinstance(output, SmokeResult)
    checks = {
        "tool_called": any(isinstance(item, ToolCallItem) for item in result.new_items),
        "structured_output": structured,
        "value_matches": structured and output.value == expected_value,
        "ref_cited": structured and output.evidence_refs == [REFERENCE_ID],
    }
    print(json.dumps({
        "model": settings.openai_model,
        "checks": checks,
        "usage": {"requests": usage.requests, "input_tokens": usage.input_tokens,
                  "output_tokens": usage.output_tokens, "total_tokens": usage.total_tokens},
        "seconds": round(time.monotonic() - started, 2),
    }, indent=2))
    return 0 if all(checks.values()) else 1


def main() -> int:
    settings = Settings()
    if not settings.assessment_available:
        print("Skipped: OPENAI_API_KEY and/or OPENAI_MODEL not set.", file=sys.stderr)
        return 2
    try:
        return asyncio.run(run(settings))
    except Exception as exc:
        # Skip the message; provider errors can include part of the API key.
        status = getattr(exc, "status_code", None)
        code = getattr(exc, "code", None)
        detail = ", ".join(part for part in (status and f"HTTP {status}", code and f"code={code}") if part)
        print(f"Failed: {type(exc).__name__}" + (f" ({detail})" if detail else ""), file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
