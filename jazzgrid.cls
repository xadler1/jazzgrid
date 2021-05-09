%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jazzgrid}[2021/05/04 LaTeX class for chord grids]

%% Page geometry options
%\DeclareOption{margins}{
%  \PassOptionsToPackage{geometry}
%}


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
\RequirePackage[left=20mm, right=8mm, top=10mm, bottom=10mm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{stackengine}
\RequirePackage[minimal]{leadsheets}
%\RequirePackage{musicography}
\RequirePackage{ifthen}
\RequirePackage{amssymb}
\RequirePackage{array}
\RequirePackage{calculator}
\RequirePackage{blindtext}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{tikz}
\RequirePackage{nopageno}
\RequirePackage[fontsize=18pt]{fontsize}

\useleadsheetslibraries{musicsymbols}
\usetikzlibrary{arrows,automata,backgrounds,calendar,chains,matrix,mindmap,patterns,petri}

\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{1pt}
\setlength{\marginparsep}{6pt}
\setlength{\marginparwidth}{60pt}

\newcommand\x{0}%
\newcommand\y{0}%
\newcommand\codashift{0}%
\newcommand\codaratio{0}%
\newcommand\npletshift{0}%
\newcommand\npletlength{0}%
\newcommand\npletstart{0}%
\newcommand\npletend{0}%
\newcommand\nplethalf{0}%

\newcommand\tablewidth{\strip@pt\textwidth}%
\newcommand\barwidth{0}%
\newcommand\barhalf{0}%
\newcommand\barthird{0}%
\newcommand\barfourth{0}%
\newcommand\rules{\strip@pt\arrayrulewidth}%

\MULTIPLY{\rules}{5}{\rules}%
\SUBTRACT{\tablewidth}{\rules}{\tablewidth}
\DIVIDE{\tablewidth}{4}{\barwidth}%
%\SUBTRACT{\barwidth}{2}{\barwidth}
\DIVIDE{\barwidth}{4}{\barfourth}%
\DIVIDE{\barwidth}{3}{\barthird}%
\DIVIDE{\barwidth}{2}{\barhalf}%
\SUBTRACT{\barfourth}{2}{\barfourth}
\SUBTRACT{\barthird}{3}{\barthird}
\SUBTRACT{\barhalf}{4}{\barhalf}

%% show holes for binder
\newcommand{\showbinderholes}[0]{%
\smash{\raise 0 pt\vbox to 0pt {\moveleft 0 pt\hbox to 0pt{%
	\begin{tikzpicture}[]%
		\draw (0,0) circle [radius=2pt];
	\end{tikzpicture}%
}}}%
}

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
	\smash{\raise 34pt\vbox to 0pt {\moveright \codashift pt\hbox to 0pt{%
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
\newenvironment{musicsection}[1]
	{%
	\reversemarginpar%
	\marginpar%
		{%
			\begin{flushright}%
				\smash{\lower1.0em\hbox{%
					\begin{tikzpicture}[]%
						\draw (1,0) node[line width=1pt,draw] {\tiny\textbf{#1}\normalsize};
					\end{tikzpicture}%
				}}%
			\end{flushright}%
		}
	}
	{%
	\hrule%
	\medskip%
	}


%% macro for the major seventh
\newcommand{\musicmaj}[0]{%
\smash{\raise 12pt\vbox to 0pt{\moveleft 2pt\hbox to 0pt{{
\begin{tikzpicture}[]%
	\draw (0,0) -- (4pt,0) -- (2pt,4pt) -- cycle;%
\end{tikzpicture}%
}}}}%
}

%% macro for the diminished seventh
\newcommand{\musicdim}[0]{%
\smash{\raise 12pt\vbox to 0pt{\moveleft 2pt\hbox to 0pt{{
\begin{tikzpicture}[]%
	\draw (0,0) circle [radius=2pt];%
\end{tikzpicture}%
}}}}%
}

%% stack used for flat/sharp/minor
\newcommand{\mystack}[2]{%
	\setstackgap{S}{2pt}%
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


%% macro for a single note name, currently unused
\newcommand{\note}[2]{%
	#1%
	\ifthenelse{ \equal{#2}{sharp} }{%
	\smash{\raise1.0ex\hbox{\scriptsize$\sharp$\normalsize}}%
	}{}%
	\ifthenelse{ \equal{#2}{flat} }{%
	\smash{\raise0.8ex\hbox{\scriptsize$\flat$\normalsize}}%
	}{}%
}

%% macro for chords
\newcommand{\chord}[6]{%
	\ifx&#6&%
		\renewcommand\y{0}%
	\else%
		\renewcommand\y{10}%

		\smash{\raise 7pt\vbox to 0pt{\moveleft 6pt\hbox to 0pt{{
			\begin{tikzpicture}[]%
				\ifthenelse{ \equal{#3}{minor} }{%
					\draw [thick] (0,0) -- (28pt,0);
				}{%
					\draw [thick] (0,0) -- (20pt,0);
				}%
			\end{tikzpicture}%
		}}}}%
		\smash{\lower 10pt\vbox to 0pt{\moveleft  0pt\hbox to 0pt{{#6}}}}%
	\fi%
	\smash{\raise \y pt\vbox{\moveleft 0pt\hbox{{%
		\textbf{#1}%
		\ifthenelse{ \equal{#3}{minor} }{%
			\ifthenelse{ \equal{#2}{sharp} }{%
				\mystack{\tiny}{\textbf{$\sharp$} \textbf{\tiny{m}\normalsize}}%
			}{}%
			\ifthenelse{ \equal{#2}{flat} }{%
				\mystack{\tiny}{\textbf{$\flat$} \textbf{\tiny{m}\normalsize}}%
			}{}%
			\ifthenelse{ \equal{#2}{} }{%
				\mystack{\tiny}{\textbf{m}}%
			}{}%
		}{%
			\ifthenelse{ \equal{#2}{sharp} }{%
				\mystack{\tiny}{\textbf{$\sharp$} \textbf{\phantom{\tiny{n}\normalsize}}}%
			}{}%
			\ifthenelse{ \equal{#2}{flat} }{%
				\mystack{\tiny}{\textbf{$\flat$}  \textbf{\phantom{\tiny{n}\normalsize}}}%
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
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{ @{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}%
	\medskip%

}

%% macro for one line of three bars
\newcommand{\barlinethree}[4]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{ |@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}| }%
		{#2} & {#3} & {#4}
	\end{tabular}%
	\medskip%

}

%% macro for one line of two bars
\newcommand{\barlinetwo}[3]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{  |@{}m{\barwidth pt}@{}|@{}m{\barwidth pt}@{}| }%
		{#2} & {#3}
	\end{tabular}%
	\medskip%

}

%% macro for one line of two bars
\newcommand{\barlineone}[2]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{ |@{} m{\barwidth pt} @{}| }%
		{#2}
	\end{tabular}%
	\medskip%

}

%% macro for bar with four beats
\newcommand{\barfour}[5]{
	\begin{tabular}[c]{m{0pt}m{\barfourth pt}@{}m{\barfourth pt}@{}m{\barfourth pt}@{}m{\barfourth pt}@{} }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}
}

%% macro for bar with three beats
\newcommand{\barthree}[4]{
	\begin{tabular}[c]{ m{0pt}m{\barthird pt}@{}m{\barthird pt}@{}m{\barthird pt}@{} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}
}

%% macro for voltas
\newcommand{\nvolta}[1]{
	\smash{\raise 34pt\vbox to 0pt {\vfil \moveright 1pt\hbox to 0pt{%
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
\newcommand{\composer}[1]{
	\newcommand\printcomposer{#1}
}

%% macro for setting the tempo
\newcommand{\tempo}[1]{
	\newcommand\printtempo{%
		\ifthenelse{ \equal{#1}{} }{
			\phantom{bpm}%
		}{%
			\tiny{{#1}bpm}\normalsize%
		}%
	}%
}

%% macro for setting the title
\renewcommand{\title}[1]{
	\newcommand\printtitle{#1}
}

%% macro for rests
\newcommand{\rest}[1]{
	\scriptsize
	\ifthenelse{ \equal{#1}{whole} \OR \equal{#1}{1} }{
		\smash{\vbox{\moveright 0.5em\hbox {\wholerest}}}%
	}{}
	\ifthenelse{ \equal{#1}{half} \OR \equal{#1}{2} }{
		\smash{\vbox{\moveright 0.5em\hbox {\halfrest}}}%
	}{}
	\ifthenelse{ \equal{#1}{quarter} \OR \equal{#1}{4} }{
		\smash{\vbox{\moveright 0.5em\hbox {\quarterrest}}}%
	}{}
	\ifthenelse{ \equal{#1}{eighth} \OR \equal{#1}{8} }{
		\smash{\vbox{\moveright 0.5em\hbox {\eighthrest}}}%
	}{}
	\ifthenelse{ \equal{#1}{sixteenth} \OR \equal{#1}{16} }{
		\smash{\vbox{\moveright 0.5em\hbox {\sixteenthrest}}}%
	}{}
	\normalsize
}

%% repeat macro
\newcommand{\repeatsection}[1]{
	\leftrepeat #1 \rightrepeat%
}

%% nplet macro; start of nplet, end of nplet, maximum width of nplet, number, position (above/under)
\newcommand{\nplet}[5]{
	\DIVIDE{\barwidth}{#3}{\npletratio}%
	\SUBTRACT{#1}{1}{\npletshift}%
	\MULTIPLY{\npletratio}{\npletshift}{\npletshift}%
	\SUBTRACT{#2}{#1}{\npletlength}%
	\MULTIPLY{\npletlength}{5}{\nplethalf}%
	\ADD{1}{\npletlength}{\npletlength}%
	\MULTIPLY{\npletratio}{\npletlength}{\npletlength}%
	\SUBTRACT{\npletlength}{\nplethalf}{\npletlength}%
	\DIVIDE{\npletlength}{2}{\nplethalf}%
	\ADD{\npletlength}{\npletshift}{\npletlength}%
	\ADD{\nplethalf}{\npletshift}{\nplethalf}%
	%
	\ifthenelse{ \equal{#5}{above}}{%
	\smash{\raise 30pt\vbox to 0pt {\vfil \moveright \npletshift pt\hbox to 0pt{%
	\begin{tikzpicture}[]
		\draw (\npletshift pt,0pt) --
		(\npletshift pt,4pt) --
		(\nplethalf pt,4pt) node[align=center,above,inner sep=0pt,outer sep=0pt]
			{\smash{\raise 7pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#4}\normalsize}}}} --
		(\npletlength pt,4pt) --
		(\npletlength pt,0pt);
	\end{tikzpicture}
	}}}%
	}{%
	\smash{\lower 5pt\vbox to 0pt {\vfil \moveright \npletshift pt\hbox to 0pt{%
	\begin{tikzpicture}[]
		\draw (\npletshift pt,0pt) --
		(\npletshift pt,-4pt) --
		(\nplethalf pt,-4pt) node[align=center,below,inner sep=0pt,outer sep=0pt]
			{\smash{\lower 2pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#4}\normalsize}}}} --
		(\npletlength pt,-4pt) --
		(\npletlength pt,0pt);
	\end{tikzpicture}
	}}}%
	}%
}

%% custom title
\renewcommand{\maketitle}[0]{
	\Large{\printtitle}\normalsize
	\hfill
	%\smash{\raise1.5ex\hbox{\tiny{\printcomposer}\normalsize}}%
	\rightstack{\tiny\raggedleft}{ {\printcomposer} {\printtempo} }
	\bigskip
	\bigskip
}

\endinput
