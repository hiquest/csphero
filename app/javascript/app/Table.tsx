import * as React from "react";
import { AnimatePresence, motion } from "motion/react";
import { memo } from "react";

export type Column<T> = {
  key: string;
  label: string;
  render: (value: T) => React.ReactNode;
  width?: string;
  align?: "left" | "right" | "center";
};

function Table<T>({
  data,
  columns,
  renderExpanded,
  getId,
  expandedIds = [],
}: {
  data: T[];
  getId: (value: T) => string;
  columns: Column<T>[];
  renderExpanded?: (value: T) => React.ReactNode;
  expandedIds?: string[];
}) {
  return (
    <div
      className="nice-table"
      role="table"
      aria-label="Nice table"
      style={{
        display: "grid",
        gridTemplateColumns: columns.map((col) => col.width || "1fr").join(" "),
      }}
    >
      <div className="header" role="row">
        {columns.map((col) => (
          <div
            role="columnheader"
            key={col.key.toString()}
            style={col.width ? { width: col.width } : {}}
            className={col.align ? `cell align-${col.align}` : "cell"}
          >
            {col.label}
          </div>
        ))}
      </div>
      {data.map((item) => (
        <React.Fragment key={getId(item)}>
          <div
            className={classes({
              row: true,
              expanded: expandedIds.includes(getId(item)),
            })}
          >
            {columns.map((col) => {
              const val = col.render(item);
              const title = typeof val === "string" ? val : col.label;

              return (
                <div
                  key={col.key.toString()}
                  className={classes({
                    cell: true,
                    [`align-${col.align}`]: !!col.align,
                  })}
                  title={title}
                >
                  {col.render(item)}
                </div>
              );
            })}
          </div>
          <AnimatePresence>
            {expandedIds.includes(getId(item)) && renderExpanded && (
              <motion.div
                className="expanded-view"
                key={`${getId(item)}-expanded`}
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -10 }}
              >
                {renderExpanded(item)}
              </motion.div>
            )}
          </AnimatePresence>
        </React.Fragment>
      ))}
    </div>
  );
}

function classes(conditions: Record<string, boolean>) {
  return Object.entries(conditions)
    .filter(([, v]) => v)
    .map(([k]) => k)
    .join(" ");
}

const MemoTable = memo(Table) as typeof Table;

export default MemoTable;
