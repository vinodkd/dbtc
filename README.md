Dont break the chain
====================

This is my weekend project to create a view similar to Github's contributions view. It, however, works on all local git repos. I needed this because:

- most of my projects are single dev: me
- some of my projects are hosted in places other than github and some not at all

Installation
-------------

1. Clone this repo or copy `dbtc.sh` and `dbtc.html` somewhere.
2. Make `dbtc.html` available via any web server. This is required because it loads up a generated csv file.

Use
---

1. Run the shell script with the following commands

		./dbtc.sh rootdir username startDt endDt

		# <rootdir> is your "projects" folder: all subdirectories will be scanned for git repos and if found, their commits will be added to a csv file in the current working dir 
		# <username> is the git username you want to display activities of
		# <startDt> and <endDt> form a date range to filter on. Format: YYYY-MM-DD

		# None of the args are optional.
	This will generate a csv file with extracted commits named `dbtc_username_startDt_endDt.csv`.
2. Copy the csv file to the same location as the html file.
3. Access `http://yourserver/.../dbtc.html`. This should show your contributions in a grid similar to the one on Github, except the rows are your projects and the columns are the days of the year.
