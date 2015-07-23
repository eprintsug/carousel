# Add the field "carousel featured" to the eprint
$c->add_dataset_field( "eprint",
	{
		name => "carousel_featured",
		type => "boolean",
		volatile => 1,
	}
);

# Change this value to change the size of your thumbnail
$c->{plugins}->{'Convert::Thumbnails'}->{params}->{sizes} = {(
    carousel => [980,450],
)};

# Add new size to list of files to be generated
$c->{thumbnail_types} = sub {
        my( $list, $repo, $doc ) = @_;
        push @$list, qw( carousel ); 
};
