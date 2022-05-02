                        -- Spritesets in SMW --
                           - What is this? -
	This is a small system to implement spritesets in a Super Mario World
ROM image that has been modified by Lunar Magic. It hijacks the inital
sprite table setup routine and adds a simple table lookup (based on sprite
index) to hold an offset that will be added when the sprite writes its OAM tiles.
In short, you can very easily mix and match sprites on a per-level basis by simply
assigning a new spriteset index to your level and preparing the offsets accordingly.
	This system is very similar, conceptually, to the one used by Yoshi's Island.
	Many parts of the ROM have been changed in minor places to change
the game's original sprites to use the system. In some cases, there is a
performance overhead of a jsr/rts (12 cycles) to store the tile. In time,
I hope to reduce these as much as I can, but my main concern is making
the patch be as unintrusive as possible.
	The game's generic sprite graphics routines in bank 01 have been modified
in-place to not require such a jsr/rts hijack, as I thought the performance penalty
would simply be too high there (many sprites call these routines and then update their
tiles accordingly).

                         - Why would I use this? -
	This system makes it reasonably easy to mix and match different sprites in
different levels while creating levels in Lunar Magic. There is still a small amount of
manual work involved, but its gererally much easier than shuffling around the game's
original sprite tilemaps, and certainly far less work than when you have to deal with
a tile conflict in the old system.

                   - Why would I use this over LX5's DSS? -
	You wish to not use SA1, or wish to not use DSS for some reason, or run into
other issues using DSS, causing you to look for alternatives. I've not used DSS, but I will
admit its a superior system with regard to ease of use, in theory. Its major downside is
it can put a lot of pressure on the vblank interrupt handler to deal with tile uploads,
whereas this patch does not incur any such overhead, but provides (arguably) similar
flexibility by offloading some of the work onto the user instead.

                            - How do I install it? -
	Note: At the time of writing, it is not completely finished. Some sprites have yet
to be remapped.
	To use it, simply patch spritesets.asm to your ROM. The patch expects
spriteset_listing.asm, remaps.asm, and the remaps directory are located in the same directory
as it. You very likely will want to insert the files in spriteset_gfx to your ROM, as well, as
these contain the 'striped' versions of the game's original graphics.
	At the moment, the patch requres a gamemode uberasm to handle the tile uploads. Insert
the contents of the 'uberasm' folder to your rom as a gamemode asm for gamemode 13.

                         - How do I create spritesets? -
	The main file for this is spriteset_listing.asm. Here, the offsets for each sprite are
defined. It may be best to see how the originals are set up to understand it best. In short,
each sprite has a pointer in the spritset_off_ptrs table to its offset table, which has an
entry for each spriteset. All you must do is modify this offset to point to the 'row' you wish
to assign the sprite to, then edit the gamemode 13 uberasm file to upload the correct graphics
file to that slot. Note that the graphics file table is reversed: the rightmost entry is the lowest
address in vram (so, the top of the page), whereas the leftmost entry is the highest (the top of
the page).
	Slots are 0x20 bytes in size, so your tile offsets should be in multiples of 0x20. If you
have a sprite that requires more than one file, you may set up the sprite's tilemap to index past
the end of the first stripe, and into the second (or third, or fourth...) See the original Big Boo,
Chucks, and the Banzai Bill for some examples, they are far too large to fit in a single file.
	After creating your spriteset, remember to modify the level_spriteset table so your
level actually loads the spriteset you just created.
	Note that sprites can share tables, as many of the originals do, as this patch is
already quite large due to the size of these tables.
	The patch has support for 0x3F (63) spritesets by default, but you can add indices
to the table to have up to 0xFF (255) of them.

                         - Does it work with custom sprites? -
	Yes. The location of the sprite load hijack is called for all sprites, including custom
ones .The ram address used for the tile offset will be populated in custom sprites as well. The
spriteset_listing.asm file has entries for custom sprites you may edit (you can even have them
share space with original sprites, if desired. From the perspective of this system, there is no
distinction between them).
	Custom sprites need to be (gently) modified to be aware of the system, of course.
 It's generally no more difficult than remapping the sprite as in the old system, except you must
map your sprite onto one (or a set) of 1KB files instead, and you must add the tile offset from the
defined RAM address when the sprite's OAM tiles are written (look for stores to $302 (+4x) and
similar). You also need togive your custom sprite index an entry in the spriteset_off_ptrs table
(the comments should help you find the relevant index)
