# Crosslake-tech
This repository is for a coding assessment which is to be submitted to Crosslake.

# Running the code
The primary file to run the task is `tasks/generate_report.rb`.

A sample input file can be found at `spec/samples/test_input.txt`.

To run the code simply run ```ruby tasks/generate_report.rb "spec/samples/test_input.txt"```

Any other input file can be used as long as it follows the same pattern.

# Approach to solving the problem
The problem has been broken down into fragments: reading the file, parsing the data, calculating scores and displaying output.

Collections have been created for reports, tracks and indicators to mimic a database table and references within those tables, since there was no strict rule that tracks and indicators would follow reports and tracks respectively.

I have not handled the Track names because they played no part in the generated report.

A simple rspec test has been written to check the overall score to be correct.
