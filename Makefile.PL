use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Finance::InteractiveBrokers::TWS',
    AUTHOR              => 'Jay Strauss <tws_at_heyjay.com>',
    VERSION_FROM        => 'lib/Finance/InteractiveBrokers/TWS.pm',
    ABSTRACT_FROM       => 'lib/Finance/InteractiveBrokers/TWS.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'        => 0,
        'version'           => 0,
        'Inline::Java'      => .5092,
        'Object::InsideOut' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Finance-InteractiveBrokers-TWS-*' },
);

use Config;
use File::Spec;

my $comp_dir = $Config{sitelib};

foreach (qw/Finance InteractiveBrokers TWS _Inline/) {

    $comp_dir = File::Spec->catfile($comp_dir, $_);
    mkdir $comp_dir;
}
