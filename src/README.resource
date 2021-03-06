The contents of the Resource directory provides Barcode Writer in Pure
PostScript as generic PostScript Level 2 named resources.

This standard delivery mechanism allows BWIPP resources to be inlined in
the prolog of any generated file, or pre-downloaded to a printer's memory or
permanent storage, or supplied by a document manager, all without any change
in the code an application generates to use the resources.

An application will generate code like the following. In the file's Setup
or PageSetup section:

/qrcode dup /uk.co.terryburton.bwipp findresource def

and in the page description where a barcode is needed:

0 0 moveto (BWIPP) (eclevel=M) qrcode

If the application needs to import the resource under a different name to avoid
a conflict, then the setup could be:

/foo /qrcode /uk.co.terryburton.bwipp findresource def

followed by

0 0 moveto (BWIPP1) (eclevel=M) foo
0 0 moveto (BWIPP2) (eclevel=M) foo
...

(The above is analogous to 'from uk.co.terryburton.bwipp import qrcode as foo'
in other languages.)

Or, to generate a few barcodes with no setup section or local name at all:

0 0 moveto (BWIPP) (eclevel=M) /qrcode /uk.co.terryburton.bwipp findresource exec

If the definitions for the routines that generate and render the barcode are
not already resident in memory then they will be fetched from a standard
resource location in a way that is transparent to the user.

This technique also reduces the possibility of namespace collision when using
the library's procedures with other code.


GhostScript

Unpack the contents of the Resource directory to somewhere accessible to the 
application.

Specify the location of the Resource files using the -sGenericResourceDir
parameter. Since this defaults to ./Resource (or equivalent) you can omit this
parameter when running GhostScript from the location of the Resource files.


Adobe Distiller

Unpack the contents of the Resource directory to somewhere accessible to the
application. Ensure that PSRESOURCEPATH contains the directory containing the
.upr file when Distiller is run. The contents should be a list of directories
separated by colons, to be searched in order with two consecutive colons to
indicate where the default location should fall within the search order.


Printer Hard Disk

If a printer with a hard disk option is used, the resources can be downloaded
once and remain available across power cycles. Resources can be downloaded with
a vendor-specific tool, or by sending them to the printer with a snippet of
PostScript at the top that queries the printer for the correct file name and
creates the file.


Printer Initial Job VM

Concatenate the resource files starting with Category/uk.co.terryburton.bwipp
followed by the remaining uk.co.terryburton.bwipp/* files in order of their
occurrence in barcode.ps. Send this to the printer with the line "true ()
startjob" added at the top where the parentheses contain the printer's startjob
password.

The named resources will remain available between jobs but will not persist
accoss power cycles.


PostScript Document Manager

Any information about common document managers is welcome.
