\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{simple-dissertation}[2017/05/12 simple dissertation class]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A document class providing a simple configuration to 
% be used for a dissertation (or actually any kind of thesis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Option processing

\newif\if@configrefs
\@configrefstrue
\newif\if@configbib
\@configbibtrue

\def\@bibbackend{biber}

\DeclareOption{norefs}{\@configrefsfalse}
\DeclareOption{nobib}{\@configbibfalse}

% Give an error if unknown options are given
\DeclareOption*{
	\ClassError{simple-dissertation}{unknown option ``\CurrentOption''}
}

\ProcessOptions\relax 

%\if@optionerror
%	\ClassError{simple-dissertation}{unknown option ``\@erroroption{}''}
%\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load memoir class
\LoadClass[11pt,a4paper,twoside,onecolumn,openright
%,final
%,draft
,fleqn % displayed math environments will be indented an amount \mathindent from the left margin (the default is to center the environments).
,openbib %each part of a bibliography entry will start on a new line, with second and succeding lines indented by \bibindent (the default is for an entry to run continuously with no indentations).
]{memoir}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input Encoding
\RequirePackage[utf8]{inputenc}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% additional packages
\RequirePackage{xifthen}
\RequirePackage{xparse}

\RequirePackage{enumitem}
%\RequirePackage{multicol}
\RequirePackage{supertabular}

\RequirePackage{tablefootnote} % in order to use \tablefootnote
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% basic additional commands
\newcommand{\ifnotempty}[2]{\ifthenelse{\isempty{#1}}{}{#2}}
\newcommand{\IfNoValue}[2]{\IfNoValueTF{#1}{}{#2}} %TODO: this should actually be calle \IfValue ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language
\RequirePackage[english]{babel}
\RequirePackage{csquotes}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font
\fontfamily{bch}
%\fontfamily{ppl}

% include boondox calligraphic alphabet
\usepackage[bb=boondox]{mathalfa} % needed so mathbb can be used for digits, too
\DeclareFontFamily{U}{BOONDOX-calo}{\skewchar\font=45 }
\DeclareFontShape{U}{BOONDOX-calo}{m}{n}{
	<-> s*[1.05] BOONDOX-r-calo}{}
\DeclareFontShape{U}{BOONDOX-calo}{b}{n}{
	<-> s*[1.05] BOONDOX-b-calo}{}
\DeclareMathAlphabet{\mathcalboondox}{U}{BOONDOX-calo}{m}{n}
\SetMathAlphabet{\mathcalboondox}{bold}{U}{BOONDOX-calo}{b}{n}
\DeclareMathAlphabet{\mathbcalboondox}{U}{BOONDOX-calo}{b}{n}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuration of memoir class

\setlrmarginsandblock{2.6cm}{3.5cm}{*}
\checkandfixthelayout 

\let\theshorttitle\empty
\newcommand\shorttitle[1]{\def\theshorttitle{#1}}
\let\oldtitle\title
\renewcommand{\title}[2][]{
	\def\inshorttitle{#1}
	\ifthenelse{\isempty{#1}}{}{
		\shorttitle{#1}
	}
	\oldtitle{#2}
	\hypersetup{pdftitle={#2}} % adding as pdf meta data
}

\let\oldauthor\author
\renewcommand{\author}[1]{
	\oldauthor{#1}
	\hypersetup{pdfauthor={#1}}
}

%\def\thekeywords\empty
%\newcommand\addkeyword[1]{
%	\ifthenelse{\isempty{\thekeywords}}{
%		\def\thekeywords{#1}	
%	}{}
%}

\maxtocdepth{subsection} % everything down to subsection appears in the toc
%\maxtocdepth{subsubsection} % everything down to subsubsection appears in the toc
\setcounter{secnumdepth}{3} % numbering down to subsubsection

\renewcommand{\cftdotsep}{\cftnodots} % no dots in the toc 

\makepagestyle{thesis-preface}
\makeoddfoot{thesis-preface}{}{}{\thepage}
\makeevenfoot{thesis-preface}{\thepage}{}{}

\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}

\copypagestyle{thesis}{thesis-preface}
\makeoddhead{thesis}{}{}{\leftmark}
\makeevenhead{thesis}{{\scshape\theshorttitle}}{}{}

\aliaspagestyle{chapter}{thesis-preface}
\aliaspagestyle{title}{empty}

\let\Appendix\appendix
%\def\appendix{\cftaddtitleline{toc}{chapter}{APPENDIX}{}\Appendix}
%TODO: not working properly, the APPENDIX is put below the first appendix chapter

\renewcommand*{\memUChead}[1]{\textsc{#1}}
%\renewcommand*{\memUChead}[1]{\textsc{\MakeTextLowercase{#1}}}

% define my own chapter style (actually styling all sections etc.)
\makechapterstyle{kittel}{
	\renewcommand{\chapnamefont}{\huge\bfseries\sffamily}
	\renewcommand{\chapnumfont}{\huge\bfseries\sffamily}
	\renewcommand{\chaptitlefont}{\huge\bfseries\sffamily}
	\setsecheadstyle{\Large\bfseries\sffamily}
	\setsubsecheadstyle{\large\bfseries\sffamily}
	\setsubsubsecheadstyle{\normalsize\bfseries\sffamily}
	\setparaheadstyle{\normalsize\itshape}
	\renewcommand{\cftchapterfont}{\normalsize\bfseries\sffamily}
	\renewcommand{\cftsectionfont}{\normalsize\sffamily}
	\renewcommand{\cftsubsectionfont}{\normalsize\sffamily}
	\renewcommand{\cftsubsubsectionfont}{\normalsize\sffamily}
	\renewcommand{\cfttablefont}{\normalsize\sffamily}
	\renewcommand{\cftfigurefont}{\normalsize\sffamily}
	\renewcommand{\cftsubfigurefont}{\normalsize\sffamily} % seems to be ignored for \subbottom had to fix it manually in the appendix
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% setting the listoftheorems font to sfseries is a tad more annoying but the lines below does the trick
	% from https://tex.stackexchange.com/questions/400618/adjust-font-in-list-of-theorems-in-memoir
	\makeatletter
	\xpatchcmd{\listoftheorems}
	{\let\thref@starttoc\@starttoc}
	{%
		\@for\thmt@envname:=\thmt@allenvs\do{%
			\@xa\let\csname l@\thmt@envname\endcsname\l@figure
		}%
		\let\cftfigurenumwidth\thmt@listnumwidth
		\let\thref@starttoc\@starttoc
	}{}{}
	\makeatother
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	\captionnamefont{\small\sffamily}
	\captiontitlefont{\small\sffamily}
	\setlength{\parskip}{1mm}
	
}
%\chapterstyle{kittel} % copy this line to use the above style

\setlength{\footmarkwidth} {0em}
\setlength{\footmarksep}   {0em}

\def\postparagraph{\@addpunct{.}} % only added if no puntuation already in place
\let\Paragraph\paragraph
\RenewDocumentCommand\paragraph{s m}{\Paragraph{#2\IfBooleanTF{#1}{}{\postparagraph{}}}}


\firmlists % reduce the vertical space for list environments
\setlength\heavyrulewidth{0.3ex}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure citations
\if@configbib
	\RequirePackage[
	style=alphabetic,
	backend=biber,
%	backref=true,
	maxbibnames=99,
	maxcitenames=1,
	mincitenames=1,
	giveninits=true,
	sortcites=true,
	]{biblatex}
	\newcommand\citet[1]{\citeauthor{#1} \cite{#1}}
	\renewcommand*{\labelalphaothers}{} % removes the + inside a citation

	\DeclareLabelalphaTemplate{
		\labelelement{
			\field[final]{shorthand}
			\field{label}
			\field[strwidth=3,strside=left,names=1]{labelname}
		}
		\labelelement{
			\field{year}    
		}
	}

	\makeatletter
	\DeclareCiteCommand{\fullcitebibentry}
	{\usebibmacro{prenote}}
	{\usedriver
		{\defcounter{minnames}{\blx@minbibnames}%
			\defcounter{maxnames}{\blx@maxbibnames}%
			\DeclareNameAlias{sortname}{default}}
		{\thefield{entrytype}}}
	{\multicitedelim}
	{\usebibmacro{postnote}}
	\makeatother
	
	
	\newcommand\publication[1]{\cite{#1} \fullcitebibentry{#1}
			\ClassWarning{simple-dissertation}{simple-dissertation: check that all authors are mentioned in a publication}
	}
	\NewDocumentCommand\arxivpublished{m o}{\cite{#1} \fullcitebibentry{#1}\IfNoValue{#2}{ (#2)}
		%TODO: check that there really is an arxiv field there
	}
	\NewDocumentCommand\unpublished{m o}{\cite{#1} \fullcitebibentry{#1}\IfNoValue{#2}{ (#2)}
	}
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Math Stuff
\RequirePackage{amsmath,amssymb,amsthm,bbold,bm, thmtools}
\RequirePackage{mathtools}
\usepackage[framemethod=tikz]{mdframed} 
\mdfsetup{skipabove=\topskip,skipbelow=\topskip}
%\renewcommand{\arraystretch}{1.2}  % matrix spacing

\makeatletter
\renewcommand\@dotsep{\cftdotsep} % take the dot spacing for list of theorems to be the one of the others (toc, lof, lot)
\makeatother

\usepackage{xpatch}
\xpatchcmd{\listoftheorems}{\@fileswfalse}{}{}{} % a fix, so that list of theoream appears in the pdf readers index, too
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure references inside the package
\PackageWarning{simple-dissertation}{simple-dissertation: something not working with the if configrefs stuff}
%\if@configrefs
	\RequirePackage{varioref}
	\RequirePackage[
	pdfa,
	hidelinks,
	breaklinks=true,
	bookmarksnumbered=true,
	pdfpagemode=UseOutlines,
	pdfpagelayout=SinglePage,
	pdffitwindow=true
	]{hyperref} 
	\usepackage{hyperxmp} % somehow needed for the meta data
	\RequirePackage[
	nameinlink,
	sort&compress, % not working?
	]{cleveref}
	\RequirePackage{nameref}
%\fi

\immediate\pdfobj stream attr{/N 3} file{sRGBIEC1966-2.1.icm}
\pdfcatalog{%
	/OutputIntents [ <<
	/Type /OutputIntent
	/S/GTS_PDFA1
	/DestOutputProfile \the\pdflastobj\space 0 R
	/OutputConditionIdentifier (sRGB IEC61966-2.1)
	/Info(sRGB IEC61966-2.1)
	>> ]
}

\newsubfloat{figure}% Allow subfloats in figure environment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% statement of authorship

\newcommand{\statementofauthorshiptitle}{Selbstständigkeitserklärung}
\newcommand\StatementOfAuthorship{
	\cleartorecto
	\section*{\statementofauthorshiptitle{}}
	\pagestyle{empty}
	\pdfbookmark{\statementofauthorshiptitle{}}{statement-of-authorship}
}

\newcommand{\SignatureLine}[1][3cm]{
	\vskip #1
	
	\noindent
	\makebox[.49\textwidth][l]{\textoverline{Place, Date\hspace{3cm}} \hspace{5cm}}\hfill\makebox[0.49\textwidth][r]{\textoverline{Signature\hspace{3cm}}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjust front matter design
\def\frontmattersectiontitlestyle{\section*}
%\def\frontmattersectiontitlestyle{\chapter*} % copy this line in your own file to adjust the style of sections in the frontmatter to be chapter-like for the front matter \FrontMatterSection{title}
\def\toctitlestyle{\chapter*}

\newcommand\FrontMatterSection[1]{
	\frontmattersectiontitlestyle{#1}
	\addcontentsline{toc}{chapter}{#1}  % add '#1' to the TOC for orientation
}

\makeatletter
\renewcommand\@tocmaketitle{%
	\toctitlestyle{\contentsname}
	\tocmark%
	\@afterheading
}
\renewcommand\@lofmaketitle{%
	\frontmattersectiontitlestyle{\listfigurename}
	\lofmark%
	\@afterheading
}
\renewcommand\@lotmaketitle{%
	\frontmattersectiontitlestyle{\listtablename}
	\lotmark%
	\@afterheading
}
\makeatother
\xpatchcmd{\listoftheorems}{1.5em}{\cftfigureindent}{}{\PatchFailed} % ensure list of theorems looks like list of figures etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cmds for comments to myself
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\theoremstyle{definition}
\newmdtheoremenv{margincomment}{Comment}
\newmdtheoremenv{margindefense}{Defense}

\newif{\ifshowcomment}
\showcommenttrue
\renewcommand{\comment}[1]{\ifshowcomment \marginpar{  \begin{margincomment} #1 \end{margincomment}  } \fi
	\PackageWarning{}{Comment: #1}
	\PackageError{simple-dissertation}{Comment: #1}
}

\newif{\ifshowdefense}
\showdefensetrue
\newcommand{\defense}[1]{\ifshowdefense \marginpar{  \begin{margindefense} #1 \end{margindefense}  } \fi}

\newcommand{\textoverline}[1]{$\overline{\mbox{#1}}$}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




\endinput
