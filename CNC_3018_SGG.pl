
 #use strict;
 use warnings;
 use Win32::GUI();

 my $filename = 'sgg_out.nc';
 open( my $fh, '>', $filename) or die "Could not open file '$filename' $!";


 my $big_font = Win32::GUI::Font->new(        # X Y Z position font
         -name => "Lucida Console", 
         -size => 18,
     );
 my $medium_font = Win32::GUI::Font->new(        # X Y Z position font
         -name => "Lucida Console", 
         -size => 12,
     );

 
    $main = Win32::GUI::Window->new(
                -name   => 'Main',
                -width  => 800,
                -height => 500,
                -text   => 'CNC_3018 Simple Gcode Generator',
                -font   => $medium_font,
        );

       $main->AddLabel(
           -text => "X Position",
           -top  => 10,
           -left => 40,
           -font => $medium_font
       );
       my $X_Position = $main->AddLabel(
           -text => "  0.000",
           -left => 40,
           -top  => 30,
           -font => $big_font,
           -foreground => 0x00ff00,
           -background => 0x000000 
       ); 

       $main->AddLabel(
           -text => "Y Position",
           -top  => 10,
           -left => 170,            # +130
           -font => $medium_font
       );
       my $Y_Position = $main->AddLabel(
           -text => "  0.000",
           -left => 170,
           -top  => 30,
           -font => $big_font,
           -foreground => 0x00ff00,
           -background => 0x000000 
       );             

       $main->AddLabel(
           -text => "Z Position",
           -top  => 10,
           -left => 300,            # +130
           -font => $medium_font
       );
       my $Z_Position = $main->AddLabel(
           -text => "  0.000",
           -left => 300,
           -top  => 30,
           -font => $big_font,
           -foreground => 0x00ff00,
           -background => 0x000000 
       ); 

       $main->AddLabel(
           -text => "Spindle Speed",
           -top  => 70,
           -left => 40,
           -font => $medium_font
       );
       my $spindle_speed = $main->AddSlider(
            -top => 70,
            -left => 180,
            -name => "Spindle",
            # -text => "Spindle_Speed",  what does this do?
            -height => 30,
            -width => 100
       );
       $main->{Spindle}->Min(800);
       $main->{Spindle}->Max(10000);
       $main->{Spindle}->Pos(5000);
       
       $main->AddLabel(
           -text => "Feed Rate",
           -top  => 100,
           -left => 40,
           -font => $medium_font
       );
       my $feed_rate = $main->AddSlider(
            -top => 100,
            -left => 180,
            -name => "Feed",
            -height => 30,
            -width => 100,
       );
       $main->{Feed}->Min(10);
       $main->{Feed}->Max(400);
       $main->{Feed}->Pos(200);

       $main->AddLabel(
           -text => "Depths:",
           -top  => 133,
           -left => 40,
           -font => $medium_font
       );
       my $txt0 = $main->AddTextfield(
           -name   => "Drill_Depth",
           -left   => 180,
           -top    => 130,
           -width  => 60,
           -height => 20,
           -multiline => 0,
           -font => $medium_font,
           -prompt => "Drill",
           -text => "3.0",
           );

       my $txt1 = $main->AddTextfield(
           -name   => "Mill_Depth",
           -left   => 310,
           -top    => 130,
           -width  => 60,
           -height => 20,
           -multiline => 0,
           -font => $medium_font,
           -prompt => "Mill",
           -text => "0.2",
           );

       $main->AddLabel(
           -text => "Destination",
           -top  => 173,
           -left => 40,
           -font => $medium_font
       );
       my $txt2 = $main->AddTextfield(
           -name   => "X",
           -left   => 200,
           -top    => 170,
           -width  => 60,
           -height => 20,
           -multiline => 0,
           -font => $medium_font,
           -prompt => "X:",
           -text => "0.0",
           );
       my $txt3 = $main->AddTextfield(
           -name   => "Y",
           -left   => 300,
           -top    => 170,
           -width  => 60,
           -height => 20,
           -multiline => 0,
           -font => $medium_font,
           -prompt => "Y:",
           -text => "0.0",
           );

       $main->AddLabel(
           -text => "Go To Destination X,Y",
           -top  => 203,
           -left => 40,
           -font => $medium_font
       );
       my $but0 = $main->AddButton(
           -name => "Goto",
           -text => "GO",
           -top  => 200,
           -left => 360,
      );

       $main->AddLabel(
           -text => "Drill at Current X,Y",
           -top  => 233,
           -left => 40,
           -font => $medium_font
       );
       my $but1 = $main->AddButton(
           -name => "Drill",
           -text => "DR",
           -top  => 230,
           -left => 360,
      );

       $main->AddLabel(
           -text => "Mill Line To Destination",
           -top  => 263,
           -left => 40,
           -font => $medium_font
       );
       my $but2 = $main->AddButton(
           -name => "Mill",
           -text => "ML",
           -top  => 260,
           -left => 360,
      );

       my $but3 = $main->AddButton(
           -name => "Header",
           -text => "Reset",
           -top  => 20,
           -left => 460,
      );
       my $but4 = $main->AddButton(
           -name => "Footer",
           -text => "Done",
           -top  => 20,
           -left => 560,
      );
      my $txt4 = $main->AddTextfield(
           -name   => "Gcode",
           -left   => 420,
           -top    => 60,
           -width  => 340,
           -height => 400,
           -multiline => 1,
           -uppercase => 1
      );

      my $txt5 = $main->AddTextfield(
           -name   => "Radius",
           -left   => 145,
           -top    => 300,
           -width  => 60,
           -height => 20,
           -multiline => 0,
           -font => $medium_font,
           -prompt => "Arc Radius",
           -text => "10.0",
           );
       $main->AddLabel(
           -text => "Clockwise ARC to Destination",
           -top  => 330,
           -left => 40,
           -font => $medium_font
       );
       my $but5 = $main->AddButton(
           -name => "CL_ARC",
           -text => "CL",
           -top  => 330,
           -left => 360,
       );
       $main->AddLabel(
           -text => "Counter Clockwise ARC",
           -top  => 360,
           -left => 40,
           -font => $medium_font
       );
       my $but6 = $main->AddButton(
           -name => "CC_ARC",
           -text => "CC",
           -top  => 360,
           -left => 360,
      );


# my $step3 = $main->AddButton(     #debug button
#      -name => "TEN_K",
#      -text => "10 K",
#      -top  => 400,
#      -left => 100,
#      );


    $main->Move( 200,100 );
    $main->Show();
    Win32::GUI::Dialog();

    sub Main_Terminate {
       close $fh;
       return -1;
    }

# debug button
#sub TEN_K_Click {

# print STDERR $main->{Spindle}->Pos();   print STDERR "  ";
# print STDERR $main->{Feed}->Pos();      print STDERR "  ";
# print STDERR $main->{Drill_Depth}->GetLine(0);
# print STDERR "\n";  
#}

sub Header_Click {
   my $x = $txt4->GetLineCount();
   $txt4->Append("( Header Gcode )\r\n");
   $txt4->Append("G21  ( mm )\r\n");
   $txt4->Append("G90  ( absolute )\r\n");
   $txt4->Append("M5   ( stop spindle )\r\n");
   $txt4->Append("G0  Z10.0    ( raise the tool )\r\n" );
   $txt4->Append("G0  X0.0 Y0.0\r\n\r\n");
   my $y = $txt4->GetLineCount();

   print2file( $x, $y );
   reset_position( 10 );
}

sub print2file {

   my ( $s, $e ) = @_;
   #print STDERR $s . ' ' . $e . "\n";   # ? , always reporting one more than actual
   $s = $s - 1;
   $e = $e - 1;

   while ($s < $e ) {
      print $fh $txt4->GetLine($s) . "\n";
      $s = $s + 1;
   }
}

sub Footer_Click {

   my $x = $txt4->GetLineCount();
   $txt4->Append("\r\n( Footer )\r\n");
   $txt4->Append("M5\r\nG0   Z10.0\r\nG0  X0.0 Y0.0\r\nM30   ( End )\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y ); 
   reset_position( ); 
}

sub Goto_Click {

   my $x = $txt4->GetLineCount();
   $txt4->Append("G0  Z10.0   (GoTo)\r\n");    # safe tool height
   $txt4->Append("G0  X" . $main->{X}->GetLine(0) . "  Y" . $main->{Y}->GetLine(0) . "\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y );
   update_position(10);

}

sub Drill_Click {

   my $rate = $main->{Feed}->Pos();
   $rate /= 8;
   my $x = $txt4->GetLineCount();
   $txt4->Append("M3  S" . $main->{Spindle}->Pos() . "\r\n");
   $txt4->Append("G0  Z0.1    ( Drill )\r\n");     # fast to close to work
   $txt4->Append("G1  Z-" . $main->{Drill_Depth}->GetLine(0) );
   $txt4->Append("  F" . $rate . "\r\n");
   $txt4->Append("G1  Z0.1   F" . $rate*8 . "\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y );
   update_position(0.1);

}

sub Mill_Click {

   my $rate = $main->{Feed}->Pos();
   my $x = $txt4->GetLineCount();
   $txt4->Append("M3  S" . $main->{Spindle}->Pos() . "\r\n");
   $txt4->Append("G0  Z0.1    ( Mill )\r\n");     # fast to close to work
   $txt4->Append("G1  Z-" . $main->{Mill_Depth}->GetLine(0) );
   $txt4->Append("  F" . $rate/8 . "\r\n");
   $txt4->Append("G1  X" . $main->{X}->GetLine(0) . "   Y" . $main->{Y}->GetLine(0));
   $txt4->Append("   F" . $rate . "\r\n");
   $txt4->Append("G1  Z0.1   F" . $rate*2 . "\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y );
   update_position(0.1);
}

sub CL_ARC_Click {

   my $rate = $main->{Feed}->Pos();
   my $x = $txt4->GetLineCount();
   $txt4->Append("M3  S" . $main->{Spindle}->Pos() . "\r\n");
   $txt4->Append("G0  Z0.1    ( CL Arc )\r\n");     # fast to close to work
   $txt4->Append("G1  Z-" . $main->{Mill_Depth}->GetLine(0) );
   $txt4->Append("  F" . $rate/8 . "\r\n");
   $txt4->Append("G2  X" . $main->{X}->GetLine(0) . "   Y" . $main->{Y}->GetLine(0));
   $txt4->Append("   F" . $rate . "   R" . $main->{Radius}->GetLine(0) . "\r\n");
   $txt4->Append("G1  Z0.1   F" . $rate*2 . "\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y );
   update_position(0.1);
}

sub CC_ARC_Click {

   my $rate = $main->{Feed}->Pos();
   my $x = $txt4->GetLineCount();
   $txt4->Append("M3  S" . $main->{Spindle}->Pos() . "\r\n");
   $txt4->Append("G0  Z0.1    ( CC Arc )\r\n");     # fast to close to work
   $txt4->Append("G1  Z-" . $main->{Mill_Depth}->GetLine(0) );
   $txt4->Append("  F" . $rate/8 . "\r\n");
   $txt4->Append("G3  X" . $main->{X}->GetLine(0) . "   Y" . $main->{Y}->GetLine(0));
   $txt4->Append("   F" . $rate . "   R" . $main->{Radius}->GetLine(0) . "\r\n");
   $txt4->Append("G1  Z0.1   F" . $rate*2 . "\r\n");
   my $y = $txt4->GetLineCount();
   print2file( $x, $y );
   update_position(0.1);
}


sub update_position {

  my $x = $main->{X}->GetLine(0);
  my $y = $main->{Y}->GetLine(0);
  my ( $z ) = @_;

  $X_Position->Text( $x );
  $Y_Position->Text( $y );
  $Z_Position->Text( $z );

}

sub reset_position {

  $X_Position->Text( '0.00' );
  $Y_Position->Text( '0.00' );
  $Z_Position->Text( '10.0' );


}

