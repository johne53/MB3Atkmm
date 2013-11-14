#! e:/program files/perl/bin/perl.exe
#  version info can be found in 'configure.ac'

require "../local-paths.lib";

$atkmm_version = "2.22.7";
$major = 2;
$minor = 22;
$micro = 7;
$binary_age = 2207;
$interface_age = 0;
$current_minus_age = 0;
$exec_prefix = "lib";

sub process_file
{
        my $outfilename = shift;
	my $infilename = $outfilename . ".in";
	
	open (INPUT, "< $infilename") || exit 1;
	open (OUTPUT, "> $outfilename") || exit 1;
	
	while (<INPUT>) {
	    s/\@PACKAGE_VERSION@/$atkmm_version/g;
	    s/\@ATKMM_MAJOR_VERSION\@/$major/g;
	    s/\@ATKMM_MINOR_VERSION\@/$minor/g;
	    s/\@ATKMM_MICRO_VERSION\@/$micro/g;
	    s/\@ATKMM_INTERFACE_AGE\@/$interface_age/g;
	    s/\@ATKMM_BINARY_AGE\@/$binary_age/g;
	    s/\@LT_CURRENT_MINUS_AGE@/$current_minus_age/g;
	    s/\@ATKMM_MODULE_NAME@/$atkmm_module_name/g;
	    s/\@PERL@/$perl_path/g;
	    s/\@prefix@/$exec_prefix/g;
	    s/\@exec_prefix@/$exec_prefix/g;
	    s/\@M4@/$m4_path/g;
	    s/\@libdir@/$generic_library_folder/g;
	    s/\@GlibBuildRootFolder@/$glib_build_root_folder/g;
	    s/\@GlibmmBuildRootFolder@/$glibmm_build_root_folder/g;
	    s/\@GtkmmBuildRootFolder@/$gtkmm_build_root_folder/g;
	    s/\@PangommBuildRootFolder@/$pangomm_build_root_folder/g;
	    s/\@GenericIncludeFolder@/$generic_include_folder/g;
	    s/\@GenericLibraryFolder@/$generic_library_folder/g;
	    s/\@GenericWin32LibraryFolder@/$generic_win32_library_folder/g;
	    s/\@GenericWin32BinaryFolder@/$generic_win32_binary_folder/g;
	    s/\@Debug32TestSuiteFolder@/$debug32_testsuite_folder/g;
	    s/\@Release32TestSuiteFolder@/$release32_testsuite_folder/g;
	    s/\@Debug32TargetFolder@/$debug32_target_folder/g;
	    s/\@Release32TargetFolder@/$release32_target_folder/g;
	    s/\@TargetSxSFolder@/$target_sxs_folder/g;
	    s/\@includedir@/$generic_include_folder/g;
	    s/\@ATKMM_API_VERSION\@/$api_version/g;
	    print OUTPUT;
	}
}

my $command=join(' ',@ARGV);

if (-1 != index($command, "-X64")) {
	$atkmm_module_name = "libatkmm64-2.0";
	$api_version = "64-2.0-0";
} else {
	$atkmm_module_name = "libatkmm32-2.0";
	$api_version = "32-2.0-0";
}

process_file ("atk/atkmmconfig.h");
process_file ("atk/atkmm.pc");

my $command=join(' ',@ARGV);
if ($command eq -buildall) {
	process_file ("build/msvc/atkmm.vsprops");
	process_file ("atk/atkmm.rc");
}