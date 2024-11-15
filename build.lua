module = "pdfjam"

-- For testing, run `l3build check`
-- For releasing, run `l3build release`
-- For major releases tag manually beforehand

version = io.popen("git describe --tags --match 'v?.*'"):read()
version = version and string.sub(version, 2) or "N.NN"
isprerelease = string.match(version, "-") ~= nil
next_version = isprerelease and string.sub(version, 1, 4) + .01 or version

installfiles = {"pdfjam"}
scriptfiles = {"pdfjam"}
scriptmanfiles = {"pdfjam.1"}
textfiles = {"COPYING", "README.md"}

checkengines = {"engine"}
lvtext = ".jam"
target_list.check.pre = function(_)
	return os.setenv("PATH", os.getenv("PATH") .. ":.") and 0 or 1
end
target_list.save.pre = target_list.check.pre

bundleunpack = function()
	if not version then return 1 end
	return os.execute("utils/build.sh " .. version)
end

ctanzip = "build/pdfjam-ctan.zip"
target_list.ctan.func = function(_)
	if not version then return 1 end
	os.execute("utils/build.sh " .. next_version)
	return runcmd("zip -r release/pdfjam-ctan.zip pdfjam", "build")
end

target_list.release = { func = function(a)
	if not version then return 1 end
	if isprerelease then target_list.tag.func(a) end
	target_list.ctan.func(a)
	return os.execute("utils/github.sh " .. next_version)
end }

target_list.tag = { func = function(_)
	os.execute("git tag --sign --edit --file=ANNOUNCEMENT.md v" .. next_version)
end }

uploadconfig = {
	pkg = "pdfjam",
	version = version,
	announcement_file = "ANNOUNCEMENT.md",
	author = "David Firth; Reuben Thomas; Markus Kurtz",
	uploader = "Markus Kurtz",
	license = "lppl",
	summary = "Shell script interface to pdfpages",
	ctanPath = "/support/pdfjam",
	repository = "https://codeberg.org/pdfjam/pdfjam",
	bugtracker = "https://codeberg.org/pdfjam/pdfjam/issues",
	description = [[The package makes available the pdfjam shell script that provides a simple interface to much of the functionality of the excellent pdfpages package (by Andreas Matthias) for LaTeX. The pdfjam script takes one or more PDF files (and/or JPG/PNG graphics files) as input, and produces one or more PDF files as output.

It is useful for joining files together, selecting pages, reducing several source pages onto one output page, etc., etc.]],
	topic = {"pdfprocess"},
}
