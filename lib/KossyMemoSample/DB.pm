package KossyMemoSample::DB;

use strict;
use warnings;
use utf8;

sub create_schema {

};

sub save_memo {
    my $content = shift;
    print "hello ----------- " . $content;
    return 0;
}

1;
