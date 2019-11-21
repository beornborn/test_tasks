# Tracker

test task

1. what is the scenario by which user-manager and user-admin can appear in application?

2. "If on a particular date a user has worked under the PreferredWorkingHourPerDay, these rows are red, otherwise green."

here is my current understanding of this functionality. please correct me where I am wrong:

example 1

PreferredWorkingHourPerDay = 8

June 9 records:
record 1: 4h - should be green
record 2: 4h - should be green
record 3: 1h - should be red

example 2

PreferredWorkingHourPerDay = 8

June 9 records:
record 1: 4h - should be green
record 2: 3h - should be green
record 3: 2h - should be red

example 3

PreferredWorkingHourPerDay = 0

June 9 records:
record 1: 4h - should be red
record 2: 3h - should be red
record 3: 2h - should be red

example 4

PreferredWorkingHourPerDay not specified

June 9 records:
record 1: 4h - should be green
record 2: 3h - should be green
record 3: 2h - should be green

3. are there any validation that should be applied for PreferredWorkingHourPerDay?

4. do we need this application to be deployed somewhere?
