# RenumberResidueID
The script renum.resid.R reads a PDB file of a protein and re-enumerates 
the residue numbers starting from one and in a sequence.
It is needed, for example, when several pdb files have been merged
together with "cat" and therefore the resid is non-sequential. You may also use it when
your PDB has residue ID (resid) is in some base other than 10 to convert it to ten.
You also have the option to convert from decimal to base 36

Use it from a terminal as 
$ Rscript renum.resid.R "membrane_ions.pdb" TRUE
or 
$ Rscript renum.resid.R "membrane_ions.pdb" FALSE
or uncomment the function wrapper and use it interactively as a function from 
within R.

The function as.base.36.R is complimentary and used if the second input above is TRUE
It turns decimals to base 36

