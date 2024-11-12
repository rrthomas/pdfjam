module = "pdfjam"

version = string.sub(io.popen("git describe --tags --match 'v?.*'"):read(), 2)
isprerelease = string.match(version, "-") ~= nil
next_version = isprerelease and string.sub(version, 1, 4) + .01 or version

installfiles = {"pdfjam"}
scriptmanfiles = {"pdfjam.1"}
textfiles = {"COPYING", "README.md"}

checkengines = {"engine"}
lvtext = ".jam"
target_list.check.pre = function(_)
	return os.setenv("PATH", os.getenv("PATH") .. ":.") and 0 or 1
end

bundleunpack = function()
	return os.execute("utils/build.sh " .. version)
end

ctanzip = "build/pdfjam-ctan.zip"
target_list.ctan.func = function(_)
	os.execute("utils/build.sh " .. next_version)
	return runcmd("zip -r pdfjam-ctan.zip pdfjam", "build")
end

target_list.release = { func = function(a)
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
	summary = "",
	ctanPath = "/support/pdfjam",
	repository = "https://codeberg.org/rrthomas/pdfjam",
	bugtracker = "https://codeberg.org/rrthomas/pdfjam/issues",
	description = "",
	topic = {},
}
