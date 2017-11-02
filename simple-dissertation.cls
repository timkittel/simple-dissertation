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
,draft
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
\fontfamily{ppl}

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

%\sloppybottom % The declaration \sloppybottom lets TeX put an extra line at the bottom of a page to avoid a widow on the following page.

\let\theshorttitle\empty
\newcommand\shorttitle[1]{\def\theshorttitle{#1}}
\let\oldtitle\title
\renewcommand{\title}[2][]{
	\def\inshorttitle{#1}
	\ifthenelse{\isempty{#1}}{}{
		\shorttitle{#1}
	}
	\oldtitle{#2}
}

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
\def\appendix{\cftaddtitleline{toc}{chapter}{APPENDIX}{}\Appendix}
%TODO: not working properly, the APPENDIX is put below the first appendix chapter

\setparaheadstyle{\normalsize\itshape}

% fix the default location for figures and tables
%\providecommand*\setfloatlocations[2]{\@namedef{fps@#1}{#2}}
%\setfloatlocations{figure}{htbp}
%\setfloatlocations{table}{htbp}

\setlength{\parskip}{1mm}
% Hm, this should remove any spacing around the math environments, but somewhoe it just removes a bit ...
%\setlength{\belowdisplayskip}{0pt}
%\setlength{\abovedisplayskip}{0pt}
%\setlength{\abovedisplayshortskip}{0pt}
%\setlength{\belowdisplayshortskip}{0pt}

\captionnamefont{\small}
\captiontitlefont{\small}
\newsubfloat{figure}% Allow subfloats in figure environment

\setlength{\footmarkwidth} {0em}
\setlength{\footmarksep}   {0em}

\def\postparagraph{\@addpunct{.}} % only added if not puntuation already in place
\let\Paragraph\paragraph
\RenewDocumentCommand\paragraph{s m}{\Paragraph{#2\IfBooleanTF{#1}{}{\postparagraph{}}}}

%\def\paragraph#1{\Paragraph{#1\postparagraph{}}} % added the point behind the paragraph title

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure citations
\if@configbib
	\RequirePackage[
	style=alphabetic,
	citestyle=alphabetic,
	backend=biber,
	backref=true,
	maxnames=99,
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
			\field[names=1]{author} 
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
	hidelinks,
	breaklinks=true,
	bookmarksnumbered=true,
	pdfpagemode=UseOutlines,
	%backref,
	% TODO: backref not working, check later
	]{hyperref} % not working?
	\RequirePackage[
	nameinlink,
	]{cleveref}
	% TODO: define the below and more
	\RequirePackage{nameref}
%\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adjust front matter design
\def\frontmattersectiontitlestyle{\section*}
%\def\frontmattersectiontitlestyle{\chapter*} % copy this line in your own file to adjust the style of sections in the frontmatter to be chapter-like for the front matter \FrontMatterSection{title}
\def\toctitlestyle{\chapter*}

\newcommand\FrontMatterSection[1]{
	\cleartorecto
	\frontmattersectiontitlestyle{#1}
	\addcontentsline{toc}{chapter}{#1}  % add '#1' to the TOC for orientation
}
\makeatletter
\renewcommand\@tocmaketitle{%
	\toctitlestyle{\contentsname}
	\tocmark%
	\@afterheading}
\renewcommand\@lofmaketitle{%
\frontmattersectiontitlestyle{\listfigurename}
\lofmark%
\@afterheading}
\renewcommand\@lotmaketitle{%
\frontmattersectiontitlestyle{\listtablename}
\lotmark%
\@afterheading}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cmds for comments to myself
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\theoremstyle{definition}
\newmdtheoremenv{margincomment}{Comment}
\newmdtheoremenv{margindefense}{Defense}

\newif{\ifshowcomment}
\showcommenttrue
\renewcommand{\comment}[1]{\ifshowcomment \marginpar{  \begin{margincomment} #1 \end{margincomment}  } \fi \PackageWarning{}{Comment: #1} }

\newif{\ifshowdefense}
\showdefensetrue
\newcommand{\defense}[1]{\ifshowdefense \marginpar{  \begin{margindefense} #1 \end{margindefense}  } \fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




\endinput
