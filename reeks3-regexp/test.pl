%gewest=("Antwerpen"      => "Vlaanderen", "Henegouwen"   => "Wallonie",
         "Limburg"        => "Vlaanderen", "Namen"        => "Wallonie",
         "Oost-Vlaanderen"=> "Vlaanderen", "Luik"         => "Wallonie",
         "Vlaams-Brabant" => "Vlaanderen", "Luxemburg"    => "Wallonie",
         "West-Vlaanderen"=> "Vlaanderen", "Waals-Brabant"=> "Wallonie");

%provincie=(
      "Aalst"       => "Oost-Vlaanderen", "Brugge"  => "West-Vlaanderen",
      "Dendermonde" => "Oost-Vlaanderen", "Ieper"   => "West-Vlaanderen",
      "Eeklo"       => "Oost-Vlaanderen", "Oostende"=> "West-Vlaanderen",
      "Oudenaarde"  => "Oost-Vlaanderen", "Kortrijk"=> "West-Vlaanderen",
      "Sint-Niklaas"=> "Oost-Vlaanderen", "Gent"    => "Oost-Vlaanderen",
      "Halle"       => "Vlaams-Brabant" , "Genk"    => "Limburg"        ,
      "Leuven"      => "Vlaams-Brabant" , "Hasselt" => "Limburg"        ,
      "Vilvoorde"   => "Vlaams-Brabant" , "Tongeren"=> "Limburg"       );

# gewest
#    prov
#       stad1
#       stad2
#       ...
#       stadn
%steden=();

for $stad (keys %provincie) {
    $prov=$provincie{$stad};
    $gew=$gewest{$prov};

    push(@{$steden{$gewest}{$prov}}, $stad);
}
