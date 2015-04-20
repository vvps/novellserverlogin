 #!/usr/bin/perl -w
    use Tk;
    use strict;

    my $mw = MainWindow->new;
    $mw->title( 'Novell server:Some Title' );
    
    $mw->Label(-text => 'IP addr of server')->pack;
    my $ipAdd = $mw->Entry(-width => 40, -text=>'192.168.11.22');
    $ipAdd->pack;

    $mw->Label(-text => 'FQDN')->pack;
    my $fqdn = $mw->Entry(-width => 40, -text=>'YourFQDNhere');
    $fqdn->pack;

    $mw->Label(-text => 'Novell username')->pack;
    my $uname = $mw->Entry(-width => 40, -text=>'Your username.context-tree');
    $uname->pack;

    $mw->Label(-text => 'Volume to be mounted')->pack;
    my $vol = $mw->Entry(-width => 40, -text=>'Name of the volume');
    $vol->pack;

    $mw->Label(-text => 'Linux username')->pack;
    my $luname = $mw->Entry(-width => 40, -text=>'your linux user name');
    $luname->pack;

    $mw->Label(-text => 'Mount Point')->pack;
    my $mpoint = $mw->Entry(-width => 40, -text=>'/mnt/novell/');
    $mpoint->pack;

    $mw->Label(-text => 'Password (Novell share)')->pack;
    my $pw = $mw->Entry(-width => 40, -show=>'?');
    $pw->pack;

    $mw->Button(
        -text => 'Log In',
        -command => sub{do_login($ipAdd, $fqdn, $uname, $vol, $luname, $mpoint, $pw)}
    )->pack;
    
    $mw->Button(
        -text => 'Log Out',
        -command => sub{do_logout($mpoint)}
    )->pack;

    MainLoop;

    sub do_login {
        my ($ipAdd, $fqdn) = @_;
        my $ipAdd_val = $ipAdd->get;
        my $fqdn_val = $fqdn->get;
	my $uname_val = $uname->get;
	my $vol_val = $vol->get;
	my $luname_val = $luname->get;
	my $mpoint_val = $mpoint->get;
	my $pw_val = $pw->get;
        my $logincmd = "ncpmount -S $ipAdd_val -A $fqdn_val -U $uname_val -P $pw_val -V $vol_val -u $luname_val $mpoint_val";
        system $logincmd;
	exit 0;
 }

     sub do_logout {
        my $mpoint_val = $mpoint->get;
	my $logoutcmd = "ncpumount $mpoint_val";
	system $logoutcmd;
	exit 0;
}

