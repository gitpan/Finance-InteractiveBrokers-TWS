use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Finance::InteractiveBrokers::TWS',
    AUTHOR              => 'Jay Strauss <me@heyjay.com>',
    VERSION_FROM        => 'lib/Finance/InteractiveBrokers/TWS.pm',
    ABSTRACT_FROM       => 'lib/Finance/InteractiveBrokers/TWS.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'        => 0,
        'version'           => 0,
        'Inline::Java'      => 0,
        'Object::InsideOut' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Finance-InteractiveBrokers-TWS-*' },
);
