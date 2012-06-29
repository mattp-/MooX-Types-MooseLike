use strictures 1;
package MooX::Types::MooseLike::Test;
use Moo;
use MooX::Types::MooseLike::Base qw/ ArrayRef Int HashRef Str /;

has an_array_of_integers => (
  is => 'ro',
  isa => ArrayRef[Int],
);
has an_array_of_hash => (
  is => 'ro',
  isa => ArrayRef[HashRef],
);
has a_hash_of_strings => (
  is => 'ro',
  isa => HashRef[Str],
);

package main;
use strictures 1;
use Test::More;
use Test::Fatal;

# Test ArrayRef[Int]
ok(MooX::Types::MooseLike::Test->new(an_array_of_integers => [6,7,10,-1]), 'ArrayRef[Int]');
like(
    exception { MooX::Types::MooseLike::Test->new(an_array_of_integers => [1.5, 2]) }, 
    qr/is not an Integer/,
    'an ArrayRef of Floats is an exception when we want an ArrayRef[Int]'
);
# Test ArrayRef[HashRef]
ok(MooX::Types::MooseLike::Test->new(an_array_of_hash => [{a => 1}, {b => 2}]), 'ArrayRef[HashRef]');
like(
    exception { MooX::Types::MooseLike::Test->new(an_array_of_hash => [{x => 1},[1,2,3]]) }, 
    qr/is not a HashRef/,
    'an ArrayRef of Integers is an exception when we want an ArrayRef[HashRef]'
);
# Test HashRef[Str]
ok(MooX::Types::MooseLike::Test->new(a_hash_of_strings => {a => 1, b => 'x'}), 'HashRef[Str]');
like(
    exception { MooX::Types::MooseLike::Test->new(a_hash_of_strings => {a => MooX::Types::MooseLike::Test->new(), b => 'x'}) }, 
    qr/is not a string/,
    'an HashRef with Objects is an exception when we want an HashRef[Str]'
);

done_testing;