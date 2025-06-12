export type Report = {
  id: number;
  website_id: number;
  created_at: string;
  raw_body: {
    "csp-report": {
      "document-uri": string;
      referrer: string;
      "violated-directive": string;
      "effective-directive": string;
      "original-policy": string;
      disposition: string;
      "blocked-uri": string;
      "line-number": number;
      "source-file": string;
      "status-code": number;
      "script-sample": string;
    };
  };

  document_uri: string;
  violated_directive: string;
  referrer: string;
  effective_directive: string;
  disposition: string;
  blocked_uri: string;
  line_number: number;
  column_number: number;
  status_code: number;
  script_sample: string;
  source_file: string;
  original_policy: string;

  user_agent: {
    family: string;
    version: string;
    os: string;
    device: string;
    device_brand: string;
    device_model: string;
  };
};

export type AggReport = {
  params: {
    violated_directive: string | null;
    disposition: string | null;
    blocked_uri: string | null;
    source_file: string | null;
  };
  count: number;
  latest_reported_at: string;
};

export type ReportTimeAgg = {
  t: string;
  violated_directives: {
    name: string;
    count: number;
  }[];
};

export type User = {
  companies: Company[];
};

export type Company = {
  id: number;
  name: string;
  websites: Website[];
};

export type Website = {
  id: number;
  domain: string;
  token: string;
  last24h_reports_count: number;
};
