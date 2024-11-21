module = "pdfjam"

-- For testing, run `l3build check`
-- For releasing, run `l3build release`
-- For major releases tag manually beforehand

---- Version information
version = io.popen("git describe --tags --match 'v?.*'"):read()
version = version and string.sub(version, 2) or "N.NN"
isprerelease = string.match(version, "-") ~= nil
next_version = isprerelease and string.sub(version, 1, 4) + .01 or version

---- Constants
-- Defaults are set later. Hence define all values we explicitly use here.
builddir = "build"
testdir = builddir .. "/test"

-- used for l3build install
installfiles = {"pdfjam"} -- also used by l3build check
scriptfiles = {"pdfjam"}
scriptmanfiles = {"pdfjam.1"}
textfiles = {"COPYING", "README.md"}

---- Test setup
local escape_pattern = function(s)
	return string.gsub(s,"[][^$()%%.*+?-]", "%%%0")
end
local rewrite_test_dir = function(s)
	return (string.gsub(s, escape_pattern(abspath(testdir)), "<TESTDIR>"))
end
local rewrite_version = function(s)
	return (string.gsub(s, "pdfjam version [%x.gN-]+", "pdfjam version N.NN."))
end

read_file = function(name)
	return io.open(name):read("a")
end

test_types = {
	jam = {
		test = ".jam",
		reference = ".jamref",
		generated = "", -- it gets an implicit .dryrun anyway
		rewrite = function(source, normalized, engine)
			local t={["engine-xe"]="xe", ["engine-pdf"]="pdf", ["engine-lua"]="lua", engine="a", dryrun="."}
			local dir=t[engine] .. "/" .. source .. ".d/"
			local f = io.open(normalized, "w")
			f:write("%%% a.tex\n", read_file(dir.."a.tex"),
				"\n%%% call.txt\n", rewrite_test_dir(read_file(dir.."call.txt")),
				"\n%%% messages.txt\n",
				rewrite_version(rewrite_test_dir(read_file(dir.."messages.txt"))))
			f:close()
		end
	},
	sh = {
		test = ".sh",
		reference = ".shref",
		generated = ".log",
		rewrite = function(source, normalized) cp(source, ".", normalized) end
	}
}

checkengines = {"dryrun"}
checkconfigs = {"build"}
lvtext = ".jam" -- Used in check_tex; cannot be overridden
test_order = {"jam", "sh"}

-- Set PATH for `l3build check` and `l3build save`
target_list.check.pre = function(_)
	return os.setenv("PATH",  "mock/paperconf/a4:.:" .. os.getenv("PATH")) and 0 or 1
end
target_list.save.pre = target_list.check.pre

---- Overwrite unpacking (used by most targets)
bundleunpack = function()
	if not version then return 1 end
	return os.execute("utils/build.sh " .. version)
end

---- Self-made targets
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

---- Information for `l3build upload`
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
