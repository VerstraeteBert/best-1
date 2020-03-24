# Om alle HTML-tags te verwijderen is
# s/<.*>//gs;
# een veel te simplistische oplossing,
# die onmiddellijk tot foutieve resultaten leidt indien in het blok dat men ineens aan het verwerken is
# (de lijn, de paragraaf of het ganse bestand), meer dan één tag voorkomt.
# Toch kun je met een minimale aanpassing van deze reguliere expressie veel betere resultaten te bekomen. Hoe ?

s/<.*?>//gs;
# non-greedy matching
