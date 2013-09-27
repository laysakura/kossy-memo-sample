package KossyMemoSample::DB;

use strict;
use warnings;
# use utf8;
use DBI;
use KossyMemoSample::Config;

sub _get_dbh {
    my $dbh = DBI->connect(
        sprintf("dbi:mysql:%s:%s", config->param('db'), config->param('host')),
        config->param('user'),
        config->param('pass'),
    ) or die 'connection failed';
    return $dbh
};

sub _create_schema {
    my $dbh = _get_dbh();
    my $table = config->param('table');

    my $ddl = <<"EOS";
create table if not exists $table (
  id INTEGER primary key,  -- always 1 since up to 1 row exists
  content TEXT not null,
  last_update DATETIME not null
) DEFAULT CHARSET=utf8;
EOS

    $dbh->do($ddl) or die 'cannot create table';
};

sub _update1 {
    my $content = shift;
    my $dbh = _get_dbh();
    my $table = config->param('table');

    my $stmt = $dbh->prepare("replace into $table values (1, ?, now());");
    $stmt->execute($dbh->quote($content)) or die 'cannot replace the row';;
};

sub save_memo {
    my $content = shift;
    _create_schema();
    _update1($content);
};

sub read_memo {
    # my $table = config->param('table');
    # my @rows = $dbh->selectall_arrayref("select * from $table");
    # $#rows == 1 or die "";
    return {
        content => "hogehoge",
        last_update => "last cristmas",
    }
};

1;
