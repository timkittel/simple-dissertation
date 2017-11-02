# mode: simple-dissertation.cls
# Tim Kittel, 2017-05-12
#include:class-memoir
#include:etex
#include:ifetex
#include:ifluatex
#include:ifpdf
#include:ifxetex
#include:mempatch
#include:latex-document
#include:latex-mathsymbols
#include:tex

# #include:subcaption

#include:biblatex
#include:hyperref
#include:cleveref
#include:xcolor

#include:amsmath
#include:amssymb
#include:amsthm
#include:bbold
#include:bm

#include:xifthen
#include:xparse
#include:supertabular
#include:enumitem

\shorttitle{short title}#n
\FrontMatterSection{title}#n
\title{title}#n
\title[short title]{title}#n
\theshorttitle#n

\mathcalboondox{symbols}#m

\ifnotempty{arg}{trueCode}
\IfNoValue{arg}{trueCode}

\citet{bibid}#c
\publication{bibid}#c
\arxivpublished{bibid}#c
\arxivpublished{bibid}[postfix]#C
\unpublished{bibid}#C
\unpublished{bibid}[postfix]#C

\paragraph*{title}#n
=======
\citet{bibid}
\shorttitle{short title}
\SpecialSection{title}
\title{title}
\title[short title]{title}
\theshorttitle
