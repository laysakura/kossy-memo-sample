package KossyMemoSample::DB;

use strict;
use warnings;
use utf8;
use DBI;
use KossyMemoSample::Config;

sub get_dbh {
    my $dbh = DBI->connect(
        sprintf("dbi:mysql:%s:%s", config->param('db'), config->param('host')),
        config->param('user'),
        config->param('pass'),
    ) or die 'connection failed:';
    return $dbh
};

sub create_schema {
    my $dbh = get_dbh();
    my $table = config->param('table');

    my $ddl = <<"EOS";
create table if not exists $table (
  content TEXT not null,
  last_update DATETIME not null
);
EOS

    $dbh->do($ddl);
};

sub save_memo {
    my $content = shift;

    create_schema();

    print "hello ----------- " . $content;
    return 0;
}

1;
