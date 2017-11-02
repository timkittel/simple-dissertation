\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{simple-dissertation}[2017/05/12 simple dissertation class]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A document class providing a simple configuration to 
% be used for a dissertation (or actually any kind of thesis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Terminate the option processing
\ProcessOptions\relax 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load memoir class
\LoadClass[12pt,a4paper,twoside,onecolumn,openright
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language
\RequirePackage[english]{babel}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font
\fontfamily{ppl}
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
\def\appendix{\Appendix\cftaddtitleline{toc}{chapter}{APPENDIX}{}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure citations
\RequirePackage[
style=alphabetic,
citestyle=alphabetic-verb,
backend=biber,
backref=true,
maxbibnames=99,
]{biblatex}
\newcommand\citet[1]{\citeauthor{#1}~\cite{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure references inside the package
\RequirePackage[
hidelinks,
breaklinks=true,
bookmarksnumbered=true,
pdfpagemode=UseOutlines,
%backref,
% TODO: backref not working, check later
]{hyperref} % not working?
\RequirePackage{cleveref}
% TODO: define the below and more
\Crefname{equation}{Eq.}{Eqs.}
\crefname{equation}{Eq.}{Eqs.}
\Crefname{figure}{Fig.}{Figs.}
\crefname{figure}{Fig.}{Figs.}
\Crefname{tabular}{Tab.}{Tabs.}
\crefname{tabular}{Tab.}{Tabs.}
\Crefname{appendix}{App.}{Apps.}
\crefname{appendix}{App.}{Apps.}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\SpecialSection[1]{
	\cleartorecto
	\section*{#1}
	\phantomsection
	\addcontentsline{toc}{chapter}{#1}  % add '#1' to the TOC for orientation
}




\endinput
