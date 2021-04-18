# Image source: https://www.psdgraphics.com/psd-icons/photoshop-padlock-icon/

library(hexSticker)
library(showtext)

font_add_google("Roboto Slab", "roboto", 900)
sticker("padlock.png", package="Keyring",
        p_size=8, s_x=1, s_y=.75, s_width = 0.8,
        h_color = "darkgrey", h_fill = "grey", p_color = "black", 
        h_size = 2, p_family = "roboto",
        filename="keyringhex.png")


