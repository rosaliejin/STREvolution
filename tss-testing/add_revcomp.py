#!/usr/bin/env python3

import sys

nucToNumber={"A":0,"C":1,"G":2,"T":3}

def ReverseComplement(seq):
    r"""Get reverse complement of a sequence.
    Converts everything to uppsercase.
    Parameters
    ----------
    seq : str
          String of nucleotides.
    Returns
    -------
    revcompseq : str
          Reverse complement of the input sequence.
    Examples
    --------
    >>> ReverseComplement("AGGCT")
    "AGCCT"
    """
    seq = seq.upper()
    newseq = ""
    size = len(seq)
    for i in range(len(seq)):
        char = seq[len(seq)-i-1]
        if char == "A":
            newseq += "T"
        elif char == "G":
            newseq += "C"
        elif char == "C":
            newseq += "G"
        elif char == "T":
            newseq += "A"
        else: newseq += "N"
    return newseq

def GetCanonicalOneStrand(repseq):
    r"""Get canonical STR sequence, considering one strand
    The canonical sequence is the first alphabetically
    out of all possible rotations. e.g. CAG -> AGC.
    Parameters
    ----------
    repseq : str
          String giving a STR motif (repeat unit sequence)
    Returns
    -------
    canon : str
          The canonical sequence of the STR motif
    Examples
    --------
    >>> GetCanonicalOneStrand("CAG")
    "AGC"
    """
    repseq = repseq.upper()
    size = len(repseq)
    canonical = repseq
    for i in range(size):
        newseq = repseq[size-i:]+repseq[0:size-i]
        for j in range(size):
            if nucToNumber[newseq[j]] < nucToNumber[canonical[j]]:
                canonical = newseq
            elif nucToNumber[newseq[j]] > nucToNumber[canonical[j]]:
                break
    return canonical


line = sys.stdin.readline()
while line != "":
    items = line.strip().split()
    items.append(GetCanonicalOneStrand(ReverseComplement(items[-1])))
    sys.stdout.write("\t".join(items)+"\n")
    line = sys.stdin.readline()
