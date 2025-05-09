%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jazzgrid}[2021/05/04 LaTeX class for chord grids]

\newcommand{\timestamp}{false}

%% Enable timestamps
\DeclareOption{timestamp}{%
	\renewcommand{\timestamp}{true}
}

%% Fallback
\DeclareOption*{
  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

%% Execute default options
\ExecuteOptions{margins}

%% Process given options
\ProcessOptions\relax

%% Load base
\LoadClass[a4paper,12pt]{article}

%% Load additional packages and commands.
\RequirePackage[left=20mm, right=8mm, top=6mm, bottom=6mm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{stackengine}
\RequirePackage[minimal]{leadsheets}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage[czech]{babel}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{pgf}
\RequirePackage{xfrac}
\RequirePackage{array}
\RequirePackage{calculator}
\RequirePackage{blindtext}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{xstring}
\RequirePackage{tikz}
\RequirePackage{nopageno}
\RequirePackage[fontsize=18pt]{fontsize}

\useleadsheetslibraries{musicsymbols}
\usetikzlibrary{arrows,automata,backgrounds,calendar,chains,matrix,mindmap,patterns,petri}

\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{1pt}
\setlength{\marginparsep}{6pt}
\setlength{\marginparwidth}{60pt}

%% vertical space defaults
\newcommand\bigvertspace{\vspace{12pt}}%
\newcommand\medvertspace{\vspace{5pt}}%
\newcommand\smallvertspace{\vspace{3pt}}%

%% characters for vertical spacing
\newcommand\characters{AÁBCČDĎEÉĚFGHIÍJKLMNOÓPQRŘSŠTŤUŮÚVWXYÝZŽaábcčdďeéěfghiíjklmnoópqrřsštťuůúvwxyýzž()\{\},.:;0123456789}%

%% chord defaults
\newcommand\chordvertshift{0}%
\newcommand\slashlinewidthupper{0}%
\newcommand\slashlinewidthlower{0}%
\newcommand\slashlinewidth{0}%

%% coda defaults
\newcommand\codashift{0}%
\newcommand\codavertshiftdefault{34}%
\newcommand\codavertshiftslim{26}%
\newcommand\codaratio{0}%

%% nvolta defaults
\newcommand\nvoltavertshiftdefault{34}%
\newcommand\nvoltavertshiftslim{26}%

%% nplet defaults
\newcommand\npletshift{0}%
\newcommand\npletlength{0}%
\newcommand\npletstart{0}%
\newcommand\npletend{0}%
\newcommand\nplethalf{0}%
\newcommand\npletraisedefault{30}%
\newcommand\npletraiseslim{22}%
\newcommand\npletlowerdefault{5}%
\newcommand\npletlowerslim{3}%

%% tablestretch defaults
\newcommand\tablestretchdefault{1.85}%
\newcommand\tablestretchslim{1.5}%

%% initialization of defaults
\newcommand\tablestretch{\tablestretchdefault}
\newcommand\nvoltavertshift{\nvoltavertshiftdefault}%
\newcommand\codavertshift{\codavertshiftdefault}%
\newcommand\npletraise{\npletraisedefault}%
\newcommand\npletlower{\npletlowerdefault}%

%% table dimensions calculations
\newcommand\tablewidth{\strip@pt\textwidth}%
\newcommand\tablewidthfour{0}%
\newcommand\tablewidtfive{0}%
\newcommand\tablewidtheight{0}%
\newcommand\barwidth{0}%
\newcommand\barwidthfive{0}%
\newcommand\barwidtheight{0}%
\newcommand\barhalf{0}%
\newcommand\barthird{0}%
\newcommand\barfourth{0}%
\newcommand\rulesfive{0}%
\newcommand\ruleseleven{0}%
\newcommand\rules{\strip@pt\arrayrulewidth}%

\MULTIPLY{\rules}{5}{\rulesfive}%
\MULTIPLY{\rules}{6}{\rulessix}%
\MULTIPLY{\rules}{11}{\ruleseleven}%

\SUBTRACT{\tablewidth}{\rulesfive}{\tablewidthfour}
\DIVIDE{\tablewidthfour}{4}{\barwidth}%

\SUBTRACT{\tablewidth}{\rulessix}{\tablewidthfive}
\DIVIDE{\tablewidthfive}{5}{\barwidthfive}%

\SUBTRACT{\tablewidth}{\ruleseleven}{\tablewidtheight}
\DIVIDE{\tablewidtheight}{8}{\barwidtheight}%

\DIVIDE{\barwidth}{4}{\barfourth}%
\DIVIDE{\barwidth}{3}{\barthird}%
\DIVIDE{\barwidth}{2}{\barhalf}%

\DIVIDE{\barwidthfive}{4}{\barfivefourth}%
\DIVIDE{\barwidthfive}{3}{\barfivethird}%
\DIVIDE{\barwidthfive}{2}{\barfivehalf}%

\DIVIDE{\barwidtheight}{4}{\bareightfourth}%
\DIVIDE{\barwidtheight}{3}{\bareightthird}%
\DIVIDE{\barwidtheight}{2}{\bareighthalf}%

\SUBTRACT{\barfourth}{4}{\barfourth}
\SUBTRACT{\barthird}{4}{\barthird}
\SUBTRACT{\barhalf}{4}{\barhalf}

\SUBTRACT{\barfivefourth}{5}{\barfivefourth}
\SUBTRACT{\barfivethird}{5}{\barfivethird}
\SUBTRACT{\barfivehalf}{5}{\barfivehalf}

\SUBTRACT{\bareightfourth}{8}{\bareightfourth}
\SUBTRACT{\bareightthird}{8}{\bareightthird}
\SUBTRACT{\bareighthalf}{8}{\bareighthalf}

%% macro for coda symbol
\newcommand{\coda}[2]{%
	\DIVIDE{\barwidth}{#2}{\codaratio}%
	\MULTIPLY{#1}{\codaratio}{\codashift}%
	\SUBTRACT{\codashift}{\codaratio}{\codashift}%
	\ADD{\codashift}{2}{\codashift}%
	\smash{\raise 37pt\vbox to 0pt {\moveright \codashift pt\hbox to 0pt{%
		\textbf{O}%
		\smash{\raise 14.0pt\vbox to 0pt {\moveleft 15.75pt\hbox to 0pt{%
			\begin{tikzpicture}[]%
				\draw [thick] (0,0) -- (16pt,0);
				\draw [thick] (8pt,8pt) -- (8pt,-8pt);
			\end{tikzpicture}%
		}}}%
	}}}%
}

%% macro for smaller coda symbol
\newcommand{\codasmall}[2]{%
	\DIVIDE{\barwidth}{#2}{\codaratio}%
	\MULTIPLY{#1}{\codaratio}{\codashift}%
	\SUBTRACT{\codashift}{\codaratio}{\codashift}%
	\ADD{\codashift}{4}{\codashift}%
	\ifthenelse{ \equal{\tablestretch}{\tablestretchslim} }{%
		\renewcommand\codavertshift{\codavertshiftslim}%
	}{%
		\renewcommand\codavertshift{\codavertshiftdefault}%
	}%
	\smash{\raise \codavertshift pt\vbox to 0pt {\moveright \codashift pt\hbox to 0pt{%
		\textbf{\scriptsize{O}\normalsize}%
		\smash{\raise 10.5pt\vbox to 0pt {\moveleft 11.5pt\hbox to 0pt{%
			\begin{tikzpicture}[]%
				\draw [thick] (0,0) -- (12pt,0);
				\draw [thick] (6pt,6pt) -- (6pt,-6pt);
			\end{tikzpicture}%
		}}}%
	}}}%
}


%% environment for sections
\newenvironment{musicsection}[2][full]{%
	\ifthenelse{ \equal{#1}{slim} }{%
		\slim{true}%
	}{}%
	\reversemarginpar%
	\marginpar{%
		\begin{flushright}%
			\smash{\lower1.0em\hbox{%
				\begin{tikzpicture}[]%
					\draw (1,0) node[line width=1pt,draw] {\tiny\textbf{#2}\normalsize};
				\end{tikzpicture}%
			}}%
		\end{flushright}%
	}%
	\catcode`\#=12%
	\catcode`\~=6%
	}%
	{%
	\slim{false}%
	\hrule%
	\medvertspace%
	\catcode`\#=6%
	\catcode`\~=13%
	}

%% macro for the major seventh
\newcommand{\musicmaj}[0]{\smash{\raise 12pt\vbox to 0pt{\moveleft 0.5pt\hbox to 0pt{\texttt{$\vartriangle$}}}}}

%% macro for the diminished seventh
\newcommand{\musicdim}[0]{\smash{\raise 11.5pt\vbox to 0pt{\moveleft 0.5pt\hbox to 0pt{\texttt{\scriptsize$\circ$\tiny}}}}}

%% stack used for flat/sharp/minor
\newcommand{\mystack}[2]{%
	\setstackgap{S}{1.5pt}%
	#1\Shortstack[l]{#2}%
	\normalsize%
}

%% stack used for additional chord notes
\newcommand{\notestack}[2]{%
	\setstackgap{S}{0pt}%
	\setstackgap{L}{8pt}%
	#1\Centerstack[l]{#2}%
	\normalsize%
}

%% stack used for composer and tempo
\newcommand{\rightstack}[2]{%
	\setstackgap{S}{4pt}%
	#1\Shortstack[r]{#2}%
	\normalsize%
}

%% stack used for date
\newcommand{\leftstack}[2]{%
	\setstackgap{S}{4pt}%
	#1\Shortstack[l]{#2}%
	\normalsize%
}

%% measures width for lower slash line, saves it to \slashwidthlower
\newcommand{\chordwidthlower}[5]{%
	\pgfmathwidth{"\textbf{#1}"}%
	\ifthenelse{ \equal{#3}{minor} \OR \equal{#3}{m} }{%
		\ifthenelse{ \equal{#4}{} \AND \equal{#5}{} }{%
			\pgfmathwidth{"\textbf{#1\tiny{m}\normalsize}"}%
		}{%
			\pgfmathwidth{"\textbf{#1\tiny{m7}\normalsize}"}%
		}%
	}{%
		\ifthenelse{ \equal{#4}{} \AND \equal{#5}{} }{%
			\pgfmathwidth{"\textbf{#1\tiny{}\normalsize}"}%
		}{%
			\pgfmathwidth{"\textbf{#1\tiny{1}\normalsize}"}%
		}%
	}%
	\StrExpand[1]{\pgfmathresult}{\slashlinewidthlower}%
}

%% measures width for upper slash line, saves it to \slashwidthupper
\newcommand{\chordwidthupper}[5]{%
	\pgfmathwidth{"\textbf{#1}"}%
	\ifthenelse{ \equal{#3}{minor} \OR \equal{#3}{m} }{%
		\ifthenelse{ \equal{#4}{} \AND \equal{#5}{} }{%
			\pgfmathwidth{"\textbf{#1\tiny{m}\normalsize}"}%
		}{%
			\pgfmathwidth{"\textbf{#1\tiny{m7}\normalsize}"}%
		}%
	}{%
		\ifthenelse{ \equal{#4}{} \AND \equal{#5}{} }{%
			\pgfmathwidth{"\textbf{#1\tiny{}\normalsize}"}%
		}{%
			\pgfmathwidth{"\textbf{#1\tiny{1}\normalsize}"}%
		}%
	}%
	\StrExpand[1]{\pgfmathresult}{\slashlinewidthupper}%
}

%% macro for chords
\newcommand{\devchord}[6]{%
	\ifx&#6&%
		\renewcommand\chordvertshift{0}%
	\else%
		\renewcommand\chordvertshift{10}%
		\MAX{\slashlinewidthlower}{\slashlinewidthupper}{\slashlinewidth}%

		\smash{\raise 7pt\vbox to 0pt{\moveleft 0pt\hbox to 0pt{{%
			\rule{\slashlinewidth pt}{1pt}
		}}}}%
		\smash{\lower 10pt\vbox to 0pt{\moveleft 0pt\hbox to 0pt{{#6}}}}%
	\fi%
	\smash{\raise \chordvertshift pt\vbox{\moveleft 0pt\hbox{{%
		\textbf{#1}%
		\ifthenelse{ \equal{#3}{minor} \OR \equal{#3}{m} }{%
			\ifthenelse{ \equal{#2}{sharp} \OR \equal{#2}{s} }{%
				\mystack{\tiny}{\textbf{$\sharp$} \textbf{\tiny{m}\normalsize}}%
			}{}%
			\ifthenelse{ \equal{#2}{flat} \OR \equal{#2}{f} }{%
				\mystack{\scriptsize}{\textbf{$\flat$} \textbf{\tiny{m}\normalsize}}%
			}{}%
			\ifthenelse{ \equal{#2}{} }{%
				\mystack{\tiny}{\textbf{m}}%
			}{}%
		}{%
			\ifthenelse{ \equal{#2}{sharp} \OR \equal{#2}{s} }{%
				\mystack{\tiny}{\textbf{$\sharp$} \textbf{\phantom{\tiny{n}\normalsize}}}%
			}{}%
			\ifthenelse{ \equal{#2}{flat} \OR \equal{#2}{f} }{%
				\mystack{\scriptsize}{\textbf{$\flat$}  \textbf{\phantom{\tiny{n}\normalsize}}}%
			}{}%
		}%
		\ifthenelse{ \equal{#4}{} }{%
			\ifthenelse{ \equal{#5}{maj} }{%
				\smash{\raise 4pt\vbox{%
				\notestack{\tiny}{\musicmaj}%
				}}%
			}{}%
			\ifthenelse{ \equal{#5}{dim} }{%
				\smash{\raise 4pt\vbox{%
					\notestack{\tiny}{\musicdim}%
				}}%
			}{}%
		}{%
			\ifthenelse{ \equal{#5}{maj} }{%
				\smash{\raise 8pt\vbox{%
					\notestack{\tiny}{\musicmaj #4}%
				}}%
			}{}%
			\ifthenelse{ \equal{#5}{dim} }{%
				\smash{\raise 8pt\vbox{%
					\notestack{\tiny}{\musicdim #4}%
				}}%
			}{}%
			\ifthenelse{ \equal{#5}{} }{%
				\smash{\raise 8pt\vbox{%
				\notestack{\tiny}{#4}%
				}}%
			}{}%
		}%
	}}}}%
}

%% does not work, seems like you can not have a stack inside anoter stack :D
\newcommand{\chordstack}[2]{%
	\mystack{}{{#1} {#2}}%
}

%% macro for one line of four bars
\newcommand{\barline}[4]{
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{ @{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}%
	\medvertspace%

}

%% macro for one line of three bars
\newcommand{\barlinethree}[4]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{ |@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}| }%
		{#2} & {#3} & {#4}
	\end{tabular}%
	\medvertspace%

}

%% macro for one line of two bars
\newcommand{\barlinetwo}[3]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{  |@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}| }%
		{#2} & {#3}
	\end{tabular}%
	\medvertspace%

}

%% macro for one line of two bars
\newcommand{\barlineone}[2]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{ |@{} m{\barwidth pt} @{}| }%
		{#2}
	\end{tabular}%
	\medvertspace%

}

%% macro for one line of eight bars
\newcommand{\barlinefive}[5]{
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{ @{}|@{}m{\barwidthfive pt}@{}|@{}m{\barwidthfive pt}@{}|@{}m{\barwidthfive pt}@{}|@{}m{\barwidthfive pt}@{}|@{}|@{}|@{}m{\barwidthfive pt}@{}| }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}%
	\medvertspace%

}

%% macro for one line of eight bars
\newcommand{\barlineeight}[8]{
	\def\arraystretch{\tablestretch}%
	\begin{tabular}[c]{ @{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{}|@{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{}m{\barwidtheight pt}@{}|@{} }
		{#1} & {#2} & {#3} & {#4} & {#5} & {#6} & {#7} & {#8}
	\end{tabular}%
	\medvertspace%

}

%% macro for bar with four beats
\newcommand{\barfour}[5]{
	\begin{tabular}[c]{ m{0pt} m{\barfourth pt} m{\barfourth pt} m{\barfourth pt} m{\barfourth pt} }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}
}

%% macro for bar with three beats
\newcommand{\barthree}[4]{
	\begin{tabular}[c]{ m{0pt} m{\barthird pt} m{\barthird pt} m{\barthird pt} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}
}

%% macro for bar with four beats
\newcommand{\barfivefour}[5]{
	\begin{tabular}[c]{ m{0pt} m{\barfivefourth pt} m{\barfivefourth pt} m{\barfivefourth pt} m{\barfivefourth pt} }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}
}

%% macro for bar with three beats
\newcommand{\barfivethree}[4]{
	\begin{tabular}[c]{ m{0pt} m{\barfivethird pt} m{\barfivethird pt} m{\barfivethird pt} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}
}


%% macro for half-size bar with four beats
\newcommand{\bareightfour}[5]{
	\begin{tabular}[c]{ m{0pt} m{\bareightfourth pt} m{\bareightfourth pt} m{\bareightfourth pt} m{\bareightfourth pt} }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}
}

%% macro for half-size bar with three beats
\newcommand{\bareightthree}[4]{
	\begin{tabular}[c]{ m{0pt} m{\bareighthalf pt} m{\bareighthalf pt} m{\bareighthalf pt} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}
}

%% macro for half-size bar with two beats
\newcommand{\bareighttwo}[3]{
	\begin{tabular}[c]{ m{0pt} m{\bareighthalf pt} m{\bareighthalf pt} }
		{#1} & {#2} & {#3}
	\end{tabular}
}

%% macro for voltas
\newcommand{\nvolta}[1]{
	\ifthenelse{ \equal{\tablestretch}{\tablestretchslim} }{%
		\renewcommand\nvoltavertshift{\nvoltavertshiftslim}%
	}{%
		\renewcommand\nvoltavertshift{\nvoltavertshiftdefault}%
	}%
	\smash{\raise \nvoltavertshift pt\vbox to 0pt {\vfil \moveright 1pt\hbox to 0pt{%
	\begin{tikzpicture}[]%
		\draw (0pt,0pt) --
		(0pt,8pt) --
		(2pt,8pt) node[align=right,below,inner sep=0pt,outer sep=0pt]
			{\smash{\lower 1pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#1}\normalsize}}}} --
		(96pt,8pt);
	\end{tikzpicture}
	}}}%
}

%% macro for primavolta
\newcommand{\primavolta}[0]{
	\nvolta{1.}
}

%% macro for secundavolta
\newcommand{\secundavolta}[0]{
	\nvolta{2.}
}

%% macro for setting the composer
\newcommand\printcomposer{\vphantom{\characters}}%

\newcommand{\composer}[1]{%
	\renewcommand\printcomposer{\vphantom{\characters}#1}%
}


%% macro for setting the tempo
\newcommand{\printtempo}{\vphantom{\tiny{\characters}\normalsize}}

\newcommand{\tempo}[1]{
	\renewcommand\printtempo{%
		\ifthenelse{ \equal{#1}{} }{%
			\vphantom{\tiny{\characters}\normalsize}%
		}{%
			\tiny{\vphantom{\characters}{#1}bpm}\normalsize%
		}%
	}%
}

%% macro for setting the title
\renewcommand{\title}[1]{
	\newcommand\printtitle{\textbf{#1}}
}

%% macro for rests
\newcommand{\rest}[1]{
	\scriptsize
	\ifthenelse{ \equal{#1}{whole} \OR \equal{#1}{1} }{%
		\smash{\vbox{\moveright 0.5em\hbox {\wholerest}}}%
	}{}%
	\ifthenelse{ \equal{#1}{half} \OR \equal{#1}{2} }{%
		\smash{\vbox{\moveright 0.5em\hbox {\halfrest}}}%
	}{}%
	\ifthenelse{ \equal{#1}{quarter} \OR \equal{#1}{4} }{%
		\smash{\vbox{\moveright 0.5em\hbox {\quarterrest}}}%
	}{}%
	\ifthenelse{ \equal{#1}{eighth} \OR \equal{#1}{8} }{%
		\smash{\vbox{\moveright 0.5em\hbox {\eighthrest}}}%
	}{}%
	\ifthenelse{ \equal{#1}{sixteenth} \OR \equal{#1}{16} }{%
		\smash{\vbox{\moveright 0.5em\hbox {\sixteenthrest}}}%
	}{}%
	\normalsize
}

%% repeat macro
\newcommand{\repeatsection}[1]{
	\leftrepeat #1 \rightrepeat%
}

%% nplet macro; start of nplet, end of nplet, maximum width of nplet, number, position (above/under)
\newcommand{\nplet}[5]{
	\,%
	\DIVIDE{\barwidth}{#3}{\npletratio}%
	\SUBTRACT{\npletratio}{4}{\npletratio}%
	\SUBTRACT{#2}{#1}{\npletlength}%
	\ADD{1}{\npletlength}{\npletlength}%
	\MULTIPLY{\npletlength}{\npletratio}{\npletlength}%
	\DIVIDE{\npletlength}{2}{\nplethalf}%
	\SUBTRACT{#1}{1}{\npletshift}%
	\MULTIPLY{\npletshift}{\npletratio}{\npletshift}%
	\ifthenelse{ \equal{#5}{above}}{%
	\ifthenelse{ \equal{\tablestretch}{\tablestretchslim} }{%
		\renewcommand\npletraise{\npletraiseslim}%
		\renewcommand\npletlower{\npletlowerslim}%
	}{%
		\renewcommand\npletraise{\npletraisedefault}%
		\renewcommand\npletlower{\npletlowerdefault}%
	}%
	\smash{\raise \npletraise pt\vbox to 0pt {\vfil \moveright \npletshift pt\hbox to 0pt{%
	\begin{tikzpicture}[]
		\draw (0pt,0pt) --
		(0pt,4pt) --
		(\nplethalf pt,4pt) node[align=center,above,inner sep=0pt,outer sep=0pt]
			{\smash{\raise 7pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#4}\normalsize}}}} --
		(\npletlength pt,4pt) --
		(\npletlength pt,0pt);
	\end{tikzpicture}
	}}}%
	}{%
	\smash{\lower \npletlower pt\vbox to 0pt {\vfil \moveright \npletshift pt\hbox to 0pt{%
	\begin{tikzpicture}[]
		\draw (0pt,0pt) --
		(0pt,-4pt) --
		(\nplethalf pt,-4pt) node[align=center,below,inner sep=0pt,outer sep=0pt]
			{\smash{\lower 1pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#4}\normalsize}}}} --
		(\npletlength pt,-4pt) --
		(\npletlength pt,0pt);
	\end{tikzpicture}
	}}}%
	}%
}

%% plus/minus signs for additional notes
\newcommand{\plus}[1]{#1\smash{\lower 0.5pt\vbox{\moveleft 0.5pt\hbox{\texttt{+}}}}}
\newcommand{\plussymbol}[0]{\smash{\lower 0.5pt\vbox{\moveleft 0.5pt\hbox{\texttt{+}}}}}
\renewcommand{\minus}[1]{#1\smash{\lower 0pt\vbox{\moveleft 0.5pt\hbox{\texttt{-}}}}}
\newcommand{\minussymbol}[0]{\smash{\lower 0pt\vbox{\moveleft 0.5pt\hbox{\texttt{-}}}}}

%% decreases vertical size of bars
\newcommand{\slim}[1]{%
	\ifthenelse{ \equal{#1}{true} }{%
		\renewcommand\tablestretch{\tablestretchslim}%
	}{%
		\renewcommand\tablestretch{\tablestretchdefault}%
	}%
}

%% custom title
\renewcommand{\maketitle}[0]{%
	\ifthenelse{ \equal{\timestamp}{true} }{%
		\leftstack{\tiny}{ {\today \vphantom{\characters}} {\vphantom{\printtempo}} }
	}{}%
	\hfill
	\rightstack{\tiny}{ {\printcomposer{}\vphantom{\characters}} {\hfill \printtempo} }


	\Large{\printtitle\vphantom{\characters}}\normalsize
	\hfill
	\bigvertspace
}

\newcommand\firstchord{}%
\newcommand\secondchord{}%

\newcommand\chordinput{ahoj}%

\newcommand\firstchordnote{}%
\newcommand\firstchordsf{}%
\newcommand\firstchordminor{}%
\newcommand\firstchorddm{}%
\newcommand\firstchordnumbers{}%
\newcommand\firstchordexpanded{}%

\newcommand\secondchordnote{}%
\newcommand\secondchordsf{}%
\newcommand\secondchordminor{}%
\newcommand\secondchorddm{}%
\newcommand\secondchordnumbers{}%
\newcommand\secondchordexpanded{}%
\newcommand\tmptest{}%


\newcommand{\chord}[1]{%
	\renewcommand\firstchordnote{}%
	\renewcommand\firstchordsf{}%
	\renewcommand\firstchordminor{}%
	\renewcommand\firstchorddm{}%
	\renewcommand\firstchordnumbers{}%
	\renewcommand\secondchordnote{}%
	\renewcommand\secondchordsf{}%
	\renewcommand\secondchordminor{}%
	\renewcommand\secondchorddm{}%
	\renewcommand\secondchordnumbers{}%

	\replacesharp{#1}

%%%%%%%%% split chords
	\StrCut{\chordinput}{/}\firstchord\secondchord%

%%%%%%%%% parse chords
%%%%%%%%% parse note
	\StrLeft{\firstchord}{1}[\firstchordnote]%
	\ifthenelse{ \equal{\firstchordnote}{} }{}{%
		\StrGobbleLeft{\firstchord}{1}[\firstchord]%
	}%

	\StrLeft{\secondchord}{1}[\secondchordnote]%
	\ifthenelse{ \equal{\secondchordnote}{} }{}{%
		\StrGobbleLeft{\secondchord}{1}[\secondchord]%
	}%

%%%%%%%%% parse sharp/flat
	\StrLeft{\firstchord}{1}[\firstchordsf]
	\ifthenelse{ \equal{\firstchordsf}{s} \OR \equal{\firstchordsf}{b} }{}{
		\renewcommand\firstchordsf{}%
	}%

	\ifthenelse{ \equal{\firstchordsf}{} }{}{%
		\StrGobbleLeft{\firstchord}{1}[\firstchord]%
	}%

	\StrLeft{\secondchord}{1}[\secondchordsf]
	\ifthenelse{ \equal{\secondchordsf}{s} \OR \equal{\secondchordsf}{b} }{}{
		\renewcommand\secondchordsf{}%
	}%

	\ifthenelse{ \equal{\secondchordsf}{} }{}{%
		\StrGobbleLeft{\secondchord}{1}[\secondchord]%
	}%

	\StrSubstitute{\firstchordsf}{b}{f}[\firstchordsf]
	\StrSubstitute{\secondchordsf}{b}{f}[\secondchordsf]

%%%%%%%%% parse numbers
	\StrCut{\firstchord}{ }\firstchord\firstchordnumbers%
	\StrCut{\secondchord}{ }\secondchord\secondchordnumbers%

%%%%%%%%% parse minor
%%%%%%%%% parse dim/maj
	% have to be expanded for +/- substitution to work
	\StrExpand[1]{\firstchordnumbers}{\firstchordexpanded}
	\StrExpand[1]{\secondchordnumbers}{\secondchordexpanded}

	\ifthenelse{ \equal{\firstchord}{m} }{%
		\renewcommand\firstchordminor{minor}%
	}{}%

	\ifthenelse{ \equal{\firstchord}{mmaj} }{%
		\renewcommand\firstchordminor{minor}%
		\ifthenelse{ \equal{\firstchordnumbers}{} }{%
			\renewcommand\firstchorddm{maj}%
		}{%
			\StrExpand[2]{\musicmaj\firstchordnumbers}{\firstchordexpanded}%
		}%
	}{}%


	\ifthenelse{ \equal{\firstchord}{mdim} }{%
		\renewcommand\firstchordminor{minor}%
		\ifthenelse{ \equal{\firstchordnumbers}{} }{%
			\renewcommand\firstchorddm{dim}%
		}{%
			\StrExpand[2]{\musicdim\firstchordnumbers}{\firstchordexpanded}%
		}%
	}{}%

	\ifthenelse{ \equal{\firstchord}{maj} }{%
		\ifthenelse{ \equal{\firstchordnumbers}{} }{%
			\renewcommand\firstchorddm{maj}%
		}{%
			\StrExpand[2]{\musicmaj\firstchordnumbers}{\firstchordexpanded}%
		}%
	}{}%

	\ifthenelse{ \equal{\firstchord}{dim} }{%
		\ifthenelse{ \equal{\firstchordexpanded}{} }{%
			\renewcommand\firstchorddm{dim}%
		}{%
			\StrExpand[2]{\musicdim\firstchordnumbers}{\firstchordexpanded}%
		}%
	}{}%


	\ifthenelse{ \equal{\secondchord}{m} }{%
		\renewcommand\secondchordminor{minor}%
	}{}%

	\ifthenelse{ \equal{\secondchord}{mmaj} }{%
		\renewcommand\secondchordminor{minor}%
		\ifthenelse{ \equal{\secondchordnumbers}{} }{%
			\renewcommand\secondchorddm{maj}%
		}{%
			\StrExpand[2]{\musicmaj\secondchordnumbers}{\secondchordexpanded}%
		}%
	}{}%


	\ifthenelse{ \equal{\secondchord}{mdim} }{%
		\renewcommand\secondchordminor{minor}%
		\ifthenelse{ \equal{\secondchordnumbers}{} }{%
			\renewcommand\secondchorddm{dim}%
		}{%
			\StrExpand[2]{\musicdim\secondchordnumbers}{\secondchordexpanded}%
		}%
	}{}%

	\ifthenelse{ \equal{\secondchord}{maj} }{%
		\ifthenelse{ \equal{\secondchordnumbers}{} }{%
			\renewcommand\secondchorddm{maj}%
		}{%
			\StrExpand[2]{\musicmaj\secondchordnumbers}{\secondchordexpanded}%
		}%
	}{}%

	\ifthenelse{ \equal{\secondchord}{dim} }{%
		\ifthenelse{ \equal{\secondchordexpanded}{} }{%
			\renewcommand\secondchorddm{dim}%
		}{%
			\StrExpand[2]{\musicdim\secondchordnumbers}{\secondchordexpanded}%
		}%
	}{}%

%%%%%%%%% substitute +/- numbers
	\expandarg
	\StrSubstitute{\firstchordexpanded}{+}{\plussymbol}[\firstchordexpanded]%
	\StrSubstitute{\firstchordexpanded}{-}{\minussymbol}[\firstchordexpanded]%

	\StrSubstitute{\secondchordexpanded}{+}{\plussymbol}[\secondchordexpanded]%
	\StrSubstitute{\secondchordexpanded}{-}{\minussymbol}[\secondchordexpanded]%

%%%%%%%%% print chords
	\ifthenelse{ \equal{\secondchordnote}{} }{%
		\devchord
		{\firstchordnote}
		{\firstchordsf}
		{\firstchordminor}
		{\firstchordexpanded}
		{\firstchorddm}{}%
	}{%
		\chordwidthlower
		{\firstchordnote}
		{\firstchordsf}
		{\firstchordminor}
		{\firstchordexpanded}
		{\firstchorddm}

		\chordwidthupper
		{\secondchordnote}
		{\secondchordsf}
		{\secondchordminor}
		{\secondchordexpanded}
		{\secondchorddm}

		\devchord
		{\firstchordnote}
		{\firstchordsf}
		{\firstchordminor}
		{\firstchordexpanded}
		{\firstchorddm}{%
			\devchord
			{\secondchordnote}
			{\secondchordsf}
			{\secondchordminor}
			{\secondchordexpanded}
			{\secondchorddm}{}
		}%
	}%
}

\catcode`\#=12
\catcode`\~=6
\newcommand{\replacesharp}[1]{%
	\StrSubstitute{~1}{#}{s}[\chordinput]
}
\catcode`\#=6
\catcode`\~=13

\endinput
