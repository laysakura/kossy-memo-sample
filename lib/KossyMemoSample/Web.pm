package KossyMemoSample::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use KossyMemoSample::DB;
use KossyMemoSample::Config;

filter 'set_prev_memo' => sub {
    my $app = shift;
    sub {
        my ( $self, $c )  = @_;

        # KossyMemoSample::DB();
        $self = $c->stash->{last_update} = "2:50";

        $app->($self,$c);
    }
};

get '/' => sub {
    my ( $self, $c )  = @_;

    my $db = KossyMemoSample::DB::fetch1();
    $c->render('index.tx',
               {
                   memo_content => $c->stash->{memo_content},
                   last_update => $c->stash->{last_update},
               });
};

post '/' => sub {
    my ( $self, $c ) = @_;
    my $res = KossyMemoSample::DB::save_memo($c->req->content);
    $c->res->status($res == 0 ? 200 : 500);
    return $c->res;
};

1;

