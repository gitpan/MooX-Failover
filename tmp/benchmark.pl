
{
  package A;
  use Moo;
  use MooX::Types::MooseLike::Base 'Int';

  has i => ( is => 'ro', isa => Int );
}

{
  package C;
  use Moo;
  use MooX::Types::MooseLike::Base 'Int';

  has i => ( is => 'ro', isa => Int );

  with 'MooX::Failover';
}

{
  package D;
  use Moo;
  # use MooX::Types::MooseLike::Base 'Str';
  # has i => ( is => 'ro', isa => Str );
}


use Benchmark qw/ cmpthese /;
use Try::Tiny;

use common::sense;

cmpthese(
    10_000,
    {
        simple    => 'simple',
        exception => 'exception',
    }
);

sub simple {
  C->new( i => 'x', failover_to => 'D' );
}

sub exception {
  try { A->new( i => 'x' ) } catch { D->new( ) };
}

