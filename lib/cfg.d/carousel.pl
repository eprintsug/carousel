
{

package EPrints::Script::Compiled;

sub run_carousel
{
	my( $self, $state, $n ) = @_;

	my $repo = $state->{repository};

	my $ids = $repo->dataset( "archive" )->search(
		filters => [
			{
				meta_fields => [qw( carousel_featured )],
				value => "TRUE",
			}
		]
	)->ids;

	my $carousel = $state->{repository}->xml->create_document_fragment;

	for( 1 .. $n->[0] )
	{
		my $id = splice @$ids, rand @$ids, 1;
		my $eprint = $repo->dataset( "archive" )->dataobj( $id );
		next unless defined $eprint;

		$carousel->appendChild( $eprint->render_citation_link( "carousel" ) );
	}

	return [ $carousel, "XHTML" ];
}

sub run_carousel_image
{
}

}
