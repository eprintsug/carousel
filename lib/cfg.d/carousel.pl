
# choose 5 random items from the 20 most recent deposits
$c->{carousel}->{defaults} = {
	search => '1|1|datestamp|archive|-||-|eprint_status:eprint_status:ANY:EQ:archive',
	limit => 20,
	size => 5,
};

# choose 6 random items from the set of all 'featured' items
#$c->{carousel}->{defaults} = {
#	search => '1|1||archive|-||-|carousel_featured:carousel_featured:ALL:EQ:TRUE|eprint_status:eprint_status:ANY:EQ:archive',
#	limit => undef,
#	size => 5,
#};

# choose 7 random items from.. everything
#$c->{carousel}->{defaults} = {
#	search => '1|1||archive|-||-|eprint_status:eprint_status:ANY:EQ:archive',
#	limit => undef,
#	size => 7,
#};


{

package EPrints::Script::Compiled;

sub run_carousel
{
	my( $self, $state, $search, $limit, $size ) = @_;

	my $repo = $state->{repository};

	my $defaults = $repo->config( qw( carousel defaults ) );
	$search = $search->[0] || $defaults->{search};
	$limit = $limit->[0] || $defaults->{limit};
	$size = $size->[0] || $defaults->{size};

	my $searchexp = EPrints::Search->new(
		session => $repo,
		dataset => $repo->dataset( "archive" ),
		allow_blank => 1,
	);
	$searchexp->set_property( "limit", $limit ) if EPrints::Utils::is_set( $limit );
	$searchexp->from_string_raw( $search );

	my $ids = $searchexp->perform_search->ids;

	my $carousel = $repo->xml->create_document_fragment;

	for( 1 .. $size )
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
	my( $self, $state, $eprint ) = @_;

	if( ! $eprint->[0]->isa( "EPrints::DataObj::EPrint") )
	{
		$self->runtime_error( "carousel_image() must be called on an eprint object." );
	}
	my $repo = $state->{repository};

	# documents with thumbnails
	my @docs = grep { defined $_->thumbnail_url( "medium" ) } $eprint->[0]->get_all_documents;

	return [ undef ] unless scalar @docs;

	# look for a 'cover' image
	for( @docs )
	{
		return [ $_ ] if $_->is_set( "content" ) && $_->value( "content" ) eq "coverimage";
	}

	# look for any other image
	for( @docs )
	{
		return [ $_ ] if $_->is_set( "format" ) && $_->value( "format" ) =~ /^image/ || $_->value( "format" ) =~ /^video/;
	}

	# just return something with a thumbnail
	return [ $docs[0] ];
}

}
