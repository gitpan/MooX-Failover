{
  package Foo;

  use Moo;

  has bar => ( is => 'ro', default => 1 );

  1;

}

use common::sense;

say Foo->bar;
