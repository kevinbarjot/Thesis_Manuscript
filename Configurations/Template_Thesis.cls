%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Masters/Doctoral Thesis 
% Class File
% Version 1.5 (22/11/16)
%
% Modified in 2017 by TVG
%
% This class has been downloaded from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Vel (vel@latextemplates.com)
% Johannes Böttcher
%
% Notes:
% 1) This class file defines the structure and layout of the template file (main.tex).
% 2) It has been written in such a way that under most circumstances you should not need
% to edit it; updating it to a newer version will be harder. If you do make changes, please change the name of
% the file and add comments to make your changes more visible.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%----------------------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{Configurations/Template_Thesis}
\ProvidesClass{\classname}[2016/11/22 v1.5 LaTeXTemplates.com]
\providecommand{\baseclass}{book}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{chapteroneline}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{headsepline}
\newbool{consistentlayout}

\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{chapterinoneline}{\booltrue{chapteroneline}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption{headsepline}{\booltrue{headsepline}}
\DeclareOption{consistentlayout}{\booltrue{consistentlayout}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}

%  Simple interface for the user to customize the chapter titles 
\ProvideDocumentCommand{\abovechapterskip}{}{\vspace*{20pt}}
\ProvideDocumentCommand{\chapterbelowskip}{}{\vspace*{40pt}}
\ProvideDocumentCommand{\chapterinbetweenskip}{}{\vspace*{20pt}}
\ProvideDocumentCommand{\autodot}{}{}
\ProvideDocumentCommand{\mdtChapapp}{}{}
\ProvideDocumentCommand{\chapteralign}{}{\raggedright}
\ProvideDocumentCommand{\chapterfont}{}{\Huge\bfseries}
\ProvideDocumentCommand{\chapterprefixfont}{}{\LARGE\bfseries}
\DeclareDocumentCommand{\@makechapterhead}{ m }{%
	\abovechapterskip
	{\parindent \z@ \chapteralign \fontfamily{pag}
		\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
		\ifbool{chapteroneline}{%
			\chapterfont \mdtChapapp\thechapter\autodot\enspace
		}{%
			\textcolor{\coulorforonglet}{\chapterprefixfont \@chapapp\space} 
			\raisebox{.75cm}[0pt][0pt]{%
				\colorbox{\coulorforonglet}{%
					\parbox[t][0.9cm][c]{0.65cm}{%
						\setlength{\fboxrule}{0pt}% Masquer trait de framebox
						\framebox[0.75cm]{%
							\chapterprefixfont \textcolor{white}{\thechapter}%
						}
					}
				}
			}
			\par\nobreak
			\chapterinbetweenskip
		}%
		\fi
		\fi
		\interlinepenalty\@M%
		\chapterfont \textcolor{\coulorforonglet}{#1} \par\nobreak
		\chapterbelowskip
	}
}
\def\@makeschapterhead#1{%
	\abovechapterskip
	{\parindent \z@ \chapteralign
		\fontfamily{pag}
		\interlinepenalty\@M
		\chapterfont  #1\par\nobreak
		\chapterbelowskip
	}
}



% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addchaptertocentry{#3}%
			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
		}{%
			\addchaptertocentry{#2}%
			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%


%----------------------------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------------------------

\ifbool{parskip}{\RequirePackage{parskip}} % If the parskip option is passed to the class, require the parskip package 


\ifbool{listtoc}{% If the liststotoc option has been passed to the class, add the lists to the table of contents
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}%
	}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}%
	}{}{}%
}

\ifbool{toctoc}{% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
	\patchcmd{\tableofcontents}{\@starttoc{toc}%
}{%
	\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
}

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}
	}{%
		\begingroup%
		\singlespace\@starttoc{lof}\endgroup%
	}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}
	}{%
		\begingroup%
		\singlespace\@starttoc{lot}\endgroup%
	}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}
	}{%
		\begingroup%
		\singlespace\@starttoc{toc}\endgroup%
	}{}{}%
}{}


%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

%\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements

\RequirePackage{scrhack} % Loads fixes for various packages

\RequirePackage{setspace} % Required for changing line spacing

\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

%\RequirePackage{siunitx} % Required for \SI commands
%\RequirePackage[output-decimal-marker={,}]{siunitx}

\RequirePackage{graphicx} % Required to include images

\RequirePackage{booktabs} % Required for better table rules

\RequirePackage{caption} % Required for customising the captions
\captionsetup{format=plain,labelfont={bf}}


%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM THESIS INFORMATION COMMANDS
%----------------------------------------------------------------------------------------

% \DeclareDocumentCommand{\thesistitle} { o m }{
% 	\IfBooleanTF{#1} {\DeclareDocumentCommand{\shorttitle}{ }{#1} {\DeclareDocumentCommand{\shorttitle}{}{#2}}}
% 	\DeclareDocumentCommand{\@title}{ }{#2}
% 	\DeclareDocumentCommand{\ttitle}{ }{#2}
% }
\NewDocumentCommand     { \thesistitle} { m } { \DeclareDocumentCommand { \ttitle       	} { } {#1}  }
\DeclareDocumentCommand { \author     } { m } { \DeclareDocumentCommand { \authorname       } { } {#1}
\DeclareDocumentCommand { \@author    } {   } {#1}   }
\NewDocumentCommand     { \supervisor } { m } { \DeclareDocumentCommand { \supname       	} { } {#1}  }
\NewDocumentCommand     { \degreen    } { m } { \DeclareDocumentCommand { \degreename    	} { } {#1}  }
\NewDocumentCommand     { \addresses  } { m } { \DeclareDocumentCommand { \addressname   	} { } {#1}  }
\NewDocumentCommand     { \university } { m } { \DeclareDocumentCommand { \univname      	} { } {#1}  }
\NewDocumentCommand     { \school     } { m } { \DeclareDocumentCommand { \schoolname    	} { } {#1}  }
\NewDocumentCommand     { \lab        } { m } { \DeclareDocumentCommand { \labname       	} { } {#1}  }
\NewDocumentCommand     { \subject    } { m } { \DeclareDocumentCommand { \subjectname   	} { } {#1}  }
\NewDocumentCommand     { \keywordsfr } { m } { \DeclareDocumentCommand { \keywordnamesfr  	} { } {#1}  }
\NewDocumentCommand     { \keywordsen } { m } { \DeclareDocumentCommand { \keywordnamesen  	} { } {#1}  }
\NewDocumentCommand     { \keywordses } { m } { \DeclareDocumentCommand { \keywordnameses  	} { } {#1}  }

\newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active  
	\if@openright\cleardoublepage\else\clearpage\fi
	\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
}

\NewDocumentCommand{\bhrule}{}{\typeout{--------------------}}
\NewDocumentCommand{\tttypeout}{m}{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{.9\linewidth}{.6pt}} % New command to make the lines in the title page
\newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures

\setcounter{tocdepth}{3} % The depth to which the document sections are printed to the table of contents
\ProvideDocumentCommand{\addchaptertocentry}{ m }{%
	\addcontentsline{toc}{chapter}{#1}%
}


%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

\usepackage{xcolor} % Required for specifying custom colours

\colorlet{mdtRed}{red!50!black}


%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}

\raggedbottom


%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes


%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------


\RequirePackage[markcase=used]{scrlayer-scrpage}


\providepairofpagestyles{firstpage}{%
	\clearpairofpagestyles%
	\ihead{\logoupc}% Inner header
	%\KOMAoptions{headsepline=false}
	%\setheadsepline{0ex}
}

\providepairofpagestyles{frontpage}{%
	\ohead[\pagemark]{\pagemark}% Outer header
}

\providepairofpagestyles{thesisSimple}{%
	\clearpairofpagestyles%
	\automark[chapter]{chapter}
	\ihead{\footnotesize\headmark}% Inner header
	\ohead[\pagemark]{\pagemark}% Outer header
	\ofoot{\ongletcote \titreongletcote}% Outer footer (pour placer onglet de chapitre)
%	\ofoot{\ongletI \titreongletI}% Outer footer (pour placer onglet de chapitre)
}

\ifoot{}% Inner footer
\ofoot{}% Outer footer

\pagestyle{thesisSimple}

\providepairofpagestyles[thesisSimple]{thesis}{%
	\automark*[section]{}%
}

% \providepairofpagestyles[thesisSimple]{review}{%
% 	\ofoot[\shorttitle/\authorname]{\shorttitle/\authorname}
% 	\ifoot[\today]{\today}
% }

\pagestyle{thesis}

\ifbool{headsepline}{\KOMAoption{headsepline}{true}}{}

\PreventPackageFromLoading[\ClassError{\classname}{Package `fancyhdr' is
incompatible\MessageBreak with this class}{The pagesyles are defined 
	using package `scrlayer-scrpage', please consult the\MessageBreak 
KOMA-script documentation for details.}]{fancyhdr}



\NewDocumentCommand{\blank@p@gestyle}{}{empty}
\NewDocumentCommand{\blankpagestyle}{ m }{%
	\ClassWarning{\classname}{\string\blankpagestyle\space is
	obsolete,\MessageBreak use \string\setblankpagestyle \space  instead}\DeclareDocumentCommand{\blank@p@gestyle}{}{#1}
}
\NewDocumentCommand{\setblankpagestyle}{ m }{\DeclareDocumentCommand{\blank@p@gestyle}{}{#1}}

\DeclareDocumentCommand\cleardoublepage{}{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\thispagestyle{\blank@p@gestyle}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}


%----------------------------------------------------------------------------------------
%	ABSTRACT PAGE DESIGN
%----------------------------------------------------------------------------------------

\DeclareDocumentCommand{\abstractauthorfont}{}{}
\DeclareDocumentCommand{\abstracttitlefont}{}{}
\newcommand{\byname}{by}
\newcommand{\abstractname}{Abstract}
\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{abstract}{ O{} }{%
		\addchap*{\abstractname}%
		{\chapteralign\normalsize\abstractauthorfont \authorname \par} % Author name
		\vspace{\baselineskip}
		{\chapteralign\parbox{.7\linewidth}{\chapteralign\normalsize\itshape\abstracttitlefont\@title}\par}% Thesis title
		\bigskip\noindent\ignorespaces
	}%
	{}%end alt-abstract
}{%
	\DeclareDocumentEnvironment{abstract}{ O{\null\vfill} }{
		\checktoopen
		\tttypeout{\abstractname}
		#1%added to be able to have abstract more than one page long
		\thispagestyle{plain}
	}
	{
		\vfill\null
	}
}



%----------------------------------------------------------------------------------------
%	ACKNOWLEDGEMENTS PAGE DESIGN
%----------------------------------------------------------------------------------------

\usepackage{xcolor}
\colorlet{mdtRed}{red!50!black}
\newcommand{\acknowledgementname}{Acknowledgements}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementname}{Acknowledgements} % Acknowledgement text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\acknowledgementname}{Danksagung} % Acknowledgement text for Germanic countries

\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\tttypeout{\acknowledgementname}
		\addchap*{\acknowledgementname}
	}
}
{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\checktoopen
		\tttypeout{\acknowledgementname}
		\thispagestyle{plain}
	}
	{
		\vfil\vfil\null
	}
}


%----------------------------------------------------------------------------------------
%	DECLARATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\authorshipname}{Declaration of Authorship}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\authorshipname}{Declaration of Authorship} % Declaration of Authorship text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\authorshipname}{Eidesstattliche Erkl\"arung} % Declaration of Authorship text for Germanic countries

\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{declaration}{}{
		\addchap*{\authorshipname}
		}{}%
}{
	\DeclareDocumentEnvironment{declaration}{}{
		\checktoopen
		\tttypeout{\authorshipname}
		\thispagestyle{plain}
		\null\vfil
		{\noindent\huge\bfseries\authorshipname\par\vspace{10pt}}
	}{}
}


%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\ifbool{consistentlayout}{
	\DeclareDocumentCommand{\dedicatory}{
		m O{\vspace*{.7\textheight} }  }{
			\checktoopen\tttypeout{Dedicatory}
			\markboth{}{}
			#2
			{\hfill\parbox{.4\textwidth}{\flushright#1\par}}
		}
}{
	\newcommand\dedicatory[2]{
		\checktoopen
		\tttypeout{Dedicatory}
		\null\vfil
		\thispagestyle{plain}
		\hfill\large\slshape #1 
		
		\hfill\large\slshape #2
		\vfil\null
	}
}


%----------------------------------------------------------------------------------------


\definecolor{color16_126_179}{rgb}{0.063,0.494,0.702}

\ifbool{hyperrefsupport}{% If the nohyperref class option has not been specified
\AtEndPreamble{\RequirePackage{hyperref}
\hypersetup{pdfpagemode={UseOutlines},
	%pagebackref, 
	bookmarksopen=true,
	bookmarksopenlevel=0,
	hypertexnames=true, % pour avoir bonnes refs pages dans biblio
	colorlinks=true, 
	linkcolor=color16_126_179,
	citecolor=blue, 
	urlcolor=blue, 
	pdfstartview={FitV},
	unicode,
	breaklinks=true,
}


\pdfstringdefDisableCommands{% If there is an explicit linebreak in a section heading (or anything printed to the pdf-bookmarks), it is replaced by a space
	\let\\\space%
}
	}
}{%nothing
}

%----------------------------------------------------------------------------------------

\endinput
% lazyLizardTracer




