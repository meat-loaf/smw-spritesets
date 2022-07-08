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
the patch be as unintrusive. However, many of the sprite graphics routines
have been rewritten to fit the tile store(s) in-place. I didn't consider
this too intrusive, as it's quite rare for other patches to change sprite graphics
routines (and the patch provides a reasonable entrypoint to any sprite graphics routine
modificationes anyhow)
	The game's generic sprite graphics routines in bank 01 have been modified
in-place to not require such a jsr/rts hijack, as I thought the performance penalty
would simply be too high there (many sprites call these routines and then update their
tiles accordingly).
	Be careful when creating your own spriteset graphics: They they must be exactly
1KB! Any larger and you risk overflowing the graphics decomp buffer and overwriting
level data during load. There is an empty 1KB file in the spriteset_gfx directory,
for convinence.

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
	The patch is intended to be used with PIXI, as I believe it to be a reasonable assumption
that PIXI will be used with the majority of SMW hacks.
	In PIXI's main.asm, add an incsrc to the spritesets file (if you mirror the directory structure,
it will be `incsrc spritesets/spritesets.asm` at the top) and look for the 'SetSpriteTables' subroutine.
Replace the RTL under the `.ret` label with `JML sprset_init' and you should be good to go.
I would like to find a nicer mechanism to do this automatically, but haven't come up with anything
I like as of yet. With this setup, though, any changes to spritesets are reapplied on running PIXI.
	If you don't wish to use PIXI, the patch can be applied independently (and will
detect if PIXI is installed or not). Just ensure that you add an SA1 detection header and
that you have PIXI's sa1def.asm file in the same location as the patch if you do this.
	There is an to use an uberasm (for gamemode 13) to handle the sprite tile uploads
or to hijack LM's code. Using the LM hijack allows you to use the bottom byte of the SP3 file number
as the spriteset to use. The spriteset used must be defined in a separate table if using uberasm.
I recommend using the LM hijack. The uberasm is more of a stopgap measure in the event the LM code
changes in an update and causes issues with the patch.

                         - How do I create spritesets? -
	The main file for this is spriteset_listing.asm. Here, the offsets for each sprite are
defined. It may be best to see how the originals are set up to understand it best (note: see the
_docs.txt tile in the spriteset_gfx directory for listings of each graphics file included). In short,
each sprite has a pointer in the spritset_off_ptrs table to its offset table, which has an
entry for each spriteset. All you must do is modify this offset to point to the 'row' you wish
to assign the sprite to, then edit the spriteset_gfx_listing table in this file
(or the uberasm, if you are using that instead) to upload the correct graphics file for that slot.
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
	The patch has support for 0x3F (64) spritesets by default, but you can add indices
to the table to have up to 0xFF (255) of them.
	Further, do not set up your spriteset offsets to loop from the bottom row to the top
row. This will break a number of the original sprites graphics routines.

                         - Does it work with custom sprites? -
	Yes, but it currently requires some modification to PIXI's code. (See the 'How do I install it?'
section above.
	Custom sprites need to be (gently) modified to be aware of the system, of course. See an included
example (imamelia's SMB3 nipper sprite). Look for the tilemap table and right before we store to $0303,y.
 It's generally no more difficult than remapping the sprite as in the old system, except you must
map your sprite onto one (or a set) of 1KB files instead, and you must add the tile offset from the
defined RAM address when the sprite's OAM tiles are written (look for stores to $302 (+4x) and
similar). You also need togive your custom sprite index an entry in the spriteset_off_ptrs table
(the comments should help you find the relevant index)
