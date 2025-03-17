library ieee;
use ieee.std_logic_1164.all;

entity somadorCompleto is
    port (x,y,cin : in std_logic;
    s,cout : out std_logic);

end entity somadorCompleto;

architecture soma of somadorCompleto is
    begin
        s <= (x xor y) xor Cin;--after 4 ns;
        cout <= (x and y) or (cin and x) or (cin and y);--after 4 ns;
end soma;