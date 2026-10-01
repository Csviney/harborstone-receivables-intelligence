import {
  CartesianGrid,
  Legend,
  Line,
  LineChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

import { day, money } from "../format";
import type { ARTrend as Trend } from "../types";

// Categorical slots 1 and 2 of the validated chart palette.
const SERIES = [
  { key: "outstanding", name: "Outstanding", color: "#2a78d6" },
  { key: "overdue", name: "Overdue", color: "#eb6834" },
] as const;

export default function TrendChart({ trend }: { trend: Trend }) {
  // Numbers are for plotting only; tooltips show the server's exact decimal strings.
  const data = trend.points.map((p) => ({
    day: p.day,
    outstanding: Number(p.outstanding),
    overdue: Number(p.overdue),
    text: { outstanding: p.outstanding, overdue: p.overdue },
  }));
  const last = data.length - 1;

  return (
    <>
      {trend.limitations.map((limitation) => (
        <p key={limitation} className="mt-1 text-xs text-red-700">
          {limitation}
        </p>
      ))}
      <div className="mt-3 h-60 w-full" aria-label="Outstanding and overdue AR by day" role="img">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={data} margin={{ top: 8, right: 84, bottom: 0, left: 0 }}>
            <CartesianGrid vertical={false} stroke="var(--color-border)" />
            <XAxis
              dataKey="day"
              tickFormatter={(value: string) => day(value).replace(/, \d{4}$/, "")}
              minTickGap={32}
              tick={{ fontSize: 12, fill: "var(--color-muted-foreground)" }}
              axisLine={false}
              tickLine={false}
            />
            <YAxis
              tickFormatter={(value: number) => `$${(value / 1_000_000).toFixed(1)}M`}
              width={52}
              tick={{ fontSize: 12, fill: "var(--color-muted-foreground)" }}
              axisLine={false}
              tickLine={false}
            />
            <Tooltip
              labelFormatter={(value) => day(String(value), "long")}
              formatter={(_value, name, item) => {
                const series = SERIES.find((s) => s.name === name);
                return [series ? money(item.payload.text[series.key]) : "", name];
              }}
            />
            <Legend verticalAlign="top" align="left" height={28} iconType="plainline" />
            {SERIES.map((series) => (
              <Line
                key={series.key}
                type="stepAfter"
                dataKey={series.key}
                name={series.name}
                stroke={series.color}
                strokeWidth={2}
                dot={false}
                activeDot={{ r: 4 }}
                isAnimationActive={false}
                label={({ index, x, y }: { index?: number; x?: number | string; y?: number | string }) =>
                  index === last ? (
                    <text x={Number(x) + 6} y={Number(y)} dy={4} fontSize={12} fill="var(--color-foreground)">
                      {series.name}
                    </text>
                  ) : (
                    <g />
                  )
                }
              />
            ))}
          </LineChart>
        </ResponsiveContainer>
      </div>
      <Movements trend={trend} />
    </>
  );
}

function Movements({ trend }: { trend: Trend }) {
  return (
    <div className="mt-3 overflow-x-auto">
      <table className="w-full min-w-[480px] text-left text-sm tabular-nums">
        <caption className="sr-only">Monthly movement in reconstructed AR</caption>
        <thead className="text-xs text-muted-foreground">
          <tr className="border-b">
            <th className="py-1.5 font-medium">Period</th>
            <th className="py-1.5 text-right font-medium">Opening</th>
            <th className="py-1.5 text-right font-medium">Sent</th>
            <th className="py-1.5 text-right font-medium">Received</th>
            <th className="py-1.5 text-right font-medium">Closing</th>
          </tr>
        </thead>
        <tbody>
          {trend.movements.map((m) => (
            <tr key={m.start} className="border-b">
              <td className="py-1.5">{period(m.start, m.end)}</td>
              <td className="py-1.5 text-right">{money(m.opening)}</td>
              <td className="py-1.5 text-right">{money(m.added)}</td>
              <td className="py-1.5 text-right">{money(m.received)}</td>
              <td className="py-1.5 text-right">{money(m.closing)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

// "May 2026" for a whole month; "Jul 1 – Jul 28, 2026" when the snapshot cuts the month short.
function period(start: string, end: string): string {
  const [year, month] = start.split("-").map(Number);
  const lastDay = new Date(Date.UTC(year, month, 0)).getUTCDate();
  if (Number(end.slice(8)) === lastDay) {
    return new Date(Date.UTC(year, month - 1, 1)).toLocaleDateString("en-US", {
      timeZone: "UTC", month: "long", year: "numeric",
    });
  }
  return `${day(start).replace(/, \d{4}$/, "")} – ${day(end)}`;
}
