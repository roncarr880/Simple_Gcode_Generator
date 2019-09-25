
 #use strict;
 use warnings;
 use Win32::GUI();

 #output file sgg_out.nc


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
       $main->{Spindle}->Min(0);
       $main->{Spindle}->Max(1000);
       $main->{Spindle}->Pos(800);
       
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
       $main->{Feed}->Max(200);
       $main->{Feed}->Pos(75);

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
           -text => "Start",
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



my $step3 = $main->AddButton(     #debug button
      -name => "TEN_K",
      -text => "10 K",
      -top  => 400,
      -left => 100,
      );


    $main->Move( 200,100 );
    $main->Show();
    Win32::GUI::Dialog();

    sub Main_Terminate {
       return -1;
    }

# debug button
sub TEN_K_Click {

 print STDERR $main->{Spindle}->Pos();   print STDERR "  ";
 print STDERR $main->{Feed}->Pos();      print STDERR "  ";
 print STDERR $main->{Drill_Depth}->GetLine(0);
 print STDERR "\n"; 
  
}

sub Header_Click {
   
   $txt4->Append("( Header Gcode )\r\n");
   $txt4->Append("G21  ( mm )\r\n");
   $txt4->Append("G90  ( absolute )\r\n");
   $txt4->Append("M5   ( stop spindle )\r\n");
   $txt4->Append("G0  Z10.0    ( raise the tool )\r\n" );
   $txt4->Append("G0  X0.0 Y0.0\r\n\r\n");

}

sub Footer_Click {

   $txt4->Append("\r\n( Footer )\r\n");
   $txt4->Append("M5\r\nG0   Z10.0\r\nG0 X0.0 Y0.0\r\nM30   ( End )\r\n");

}

sub Goto_Click {

   $txt4->Append("G0   Z10.0\r\n");    # safe tool height
   $txt4->Append("G0   X" . $main->{X}->GetLine(0) . "  Y" . $main->{Y}->GetLine(0) . "\r\n");
}