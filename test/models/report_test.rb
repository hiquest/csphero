require "test_helper"

class ReportTest < ActiveSupport::TestCase

  test "parses a report" do
    raw_body = "{\"csp-report\":{\"document-uri\":\"https://www.candlapp.com/\",\"referrer\":\"\",\"violated-directive\":\"script-src\",\"effective-directive\":\"script-src\",\"original-policy\":\"default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data: books.google.com; object-src 'none'; script-src 'self' https:; style-src 'self' https: 'unsafe-inline'; report-uri https://app.csphero.com/report/PTvJPr6d\",\"disposition\":\"enforce\",\"blocked-uri\":\"eval\",\"line-number\":1,\"column-number\":1,\"status-code\":200,\"script-sample\":\"\"}}"

    c = Company.create!(name: "Candl")
    ws = Website.create!(company: c, domain: "domain.org")

    report = Report.create!(raw_body: raw_body, website: ws)
    report.parse!
    report.reload

    assert_equal "https://www.candlapp.com/", report.document_uri
    assert_equal "script-src", report.violated_directive
    assert_equal "script-src", report.effective_directive
    assert_equal "eval", report.blocked_uri
    assert_equal 1, report.line_number
    assert_equal 1, report.column_number
    assert_equal 200, report.status_code
    assert_equal "", report.script_sample
    assert_equal "enforce", report.disposition
    assert_equal "", report.referrer
    assert_equal "eval", report.blocked_uri
    assert_nil report.source_file
  end

  test "parses a report with a source file" do
    raw_body = "{\"csp-report\":{\"blocked-uri\":\"blob\",\"column-number\":453,\"disposition\":\"enforce\",\"document-uri\":\"https://www.candlapp.com/app\",\"effective-directive\":\"img-src\",\"line-number\":921,\"original-policy\":\"default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data: https://books.google.com; object-src 'none'; script-src 'self' https:; style-src 'self' https: 'unsafe-inline'; report-uri https://app.csphero.com/report/PTvJPr6d\",\"referrer\":\"https://www.candlapp.com/app/\",\"source-file\":\"https://d38512d99udfkd.cloudfront.net/assets/app-118da6ed9af05a4fd3ad9cfc4dbc7a638aa2563cc9b05d8f928d606d93c97989.js\",\"status-code\":200,\"violated-directive\":\"img-src\"}}"

    c = Company.create!(name: "Candl")
    ws = Website.create!(company: c, domain: "domain.org")

    report = Report.create!(raw_body: raw_body, website: ws)
    report.parse!
    report.reload

    assert_equal "https://www.candlapp.com/app", report.document_uri
    assert_equal "img-src", report.violated_directive
    assert_equal "img-src", report.effective_directive
    assert_equal "blob", report.blocked_uri
    assert_equal 921, report.line_number
    assert_equal 453, report.column_number
    assert_equal 200, report.status_code
    assert_nil report.script_sample
    assert_equal "enforce", report.disposition
    assert_equal "https://www.candlapp.com/app/", report.referrer
    assert_equal "blob", report.blocked_uri
    assert_equal "https://d38512d99udfkd.cloudfront.net/assets/app-118da6ed9af05a4fd3ad9cfc4dbc7a638aa2563cc9b05d8f928d606d93c97989.js", report.source_file
  end

  test "filtering" do
    c = Company.create!(name: "Candl")
    ws = Website.create!(company: c, domain: "domain.org")

    report = ws.reports.create!(
      raw_body: "",
      violated_directive: "script-src",
      disposition: "enforce",
      blocked_uri: "",
      source_file: ""
    )

    res = Report.filter(
      ws,
      {
        violated_directive: "script-src",
      }
    )

    assert_equal 1, res.count

    res = Report.filter(
      ws,
      {
        blocked_uri: "https://www.candlapp.com/"
      }
    )
    assert_equal 0, res.count

    res = Report.filter(
      ws,
      {
        blocked_uri: "__NONE__"
      }
    )
    assert_equal 1, res.count
  end

  test "filtering should treat no disposition and enforce" do
    c = Company.create!(name: "Candl")
    ws = Website.create!(company: c, domain: "domain.org")

    report = ws.reports.create!(
      raw_body: "",
      violated_directive: "script-src",
      disposition: nil,
      blocked_uri: "",
      source_file: ""
    )

    res = Report.filter(
      ws,
      {
        violated_directive: "script-src",
        disposition: "enforce"
      }
    )

    assert_equal 1, res.count

    res = Report.filter(
      ws,
      {
        violated_directive: "script-src",
        disposition: "report"
      }
    )

    assert_equal 0, res.count
  end

end
