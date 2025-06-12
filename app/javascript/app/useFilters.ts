import { useEffect, useState } from "react";
import { useSearchParams } from "react-router-dom";

type FilterValues = {
  range: Range;
  disposition: Disposition;
  violated_directive: string | null;
  blocked_uri: string | null;
  source_file: string | null;
  filter_extensions: "0" | "1";
};

type Filter = keyof FilterValues;

// Range
export type Range = "24h" | "7d" | "30d" | "90d";
const DEFAULT_RANGE: Range = "24h";
const isValidRange = (range: string | null): range is Range => {
  return (
    range === "24h" || range === "7d" || range === "30d" || range === "90d"
  );
};

// Disposition
export type Disposition = "enforce" | "report";
const DEFAULT_DISPOSITION: Disposition = "enforce";
const isValidDisposition = (
  disposition: string | null
): disposition is Disposition => {
  return disposition === "enforce" || disposition === "report";
};

const useFilter = (filters: Filter[]) => {
  const [searchParams, setSearchParams] = useSearchParams();

  const [range, setRange] = useState<Range>(DEFAULT_RANGE);
  const [disposition, setDisposition] =
    useState<Disposition>(DEFAULT_DISPOSITION);
  const [violatedDirective, setViolatedDirective] = useState<string | null>();
  const [blockedUri, setBlockedUri] = useState<string | null>();
  const [sourceFile, setSourceFile] = useState<string | null>();
  const [filterExtensions, setFilterExtensions] = useState<"0" | "1">("0");

  useEffect(() => {
    const params = new URLSearchParams(searchParams);
    filters.forEach((f) => {
      if (params.has(f)) {
        const value = params.get(f);

        if (f === "range") {
          // range
          if (isValidRange(value)) {
            setRange(value);
          } else {
            params.set(f, DEFAULT_RANGE);
            setSearchParams(params);
            setRange(DEFAULT_RANGE);
          }
        } else if (f === "disposition") {
          // disposition
          if (isValidDisposition(value)) {
            setDisposition(value);
          } else {
            params.set(f, DEFAULT_DISPOSITION);
            setSearchParams(params);
            setDisposition(DEFAULT_DISPOSITION);
          }
        } else if (f === "violated_directive") {
          // violated_directive
          setViolatedDirective(value);
        } else if (f === "blocked_uri") {
          // blocked_uri
          setBlockedUri(value);
        } else if (f === "source_file") {
          // source_file
          setSourceFile(value);
        } else if (f === "filter_extensions") {
          if (value === "1") {
            setFilterExtensions("1");
          } else {
            setFilterExtensions("0");
          }
        }
      } else {
        if (f === "range") {
          // range
          params.set(f, DEFAULT_RANGE);
          setSearchParams(params);
          setRange(DEFAULT_RANGE);
        } else if (f === "disposition") {
          // disposition
          params.set(f, DEFAULT_DISPOSITION);
          setSearchParams(params);
          setDisposition(DEFAULT_DISPOSITION);
        } else if (f === "violated_directive") {
          // violated_directive
          setViolatedDirective(null);
        } else if (f === "filter_extensions") {
          // violated_directive
          setFilterExtensions("0");
        }
      }
    });
  }, [searchParams]);

  const onFilterChange = <T extends Filter>(
    filter: T,
    value: FilterValues[T]
  ) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(filter);
    } else {
      params.set(filter, value);
    }
    setSearchParams(params);
  };

  return {
    filters: {
      range,
      disposition,
      violatedDirective,
      blockedUri,
      sourceFile,
      filterExtensions,
    },
    onFilterChange,
  };
};

export default useFilter;
