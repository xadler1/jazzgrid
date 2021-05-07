%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jazzgrid}[2021/05/04 LaTeX class for chord grids]

%% Page geometry options
\DeclareOption{margins}{
  \PassOptionsToPackage{left=20mm, right=8mm, top=10mm, bottom=10mm}{geometry}
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
\RequirePackage{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{stackengine}
%\RequirePackage{musicography}
\RequirePackage[minimal]{leadsheets}
\RequirePackage{ifthen}
\RequirePackage{array}
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
\begin{tikzpicture}[]%
	\draw (0,0) -- (4pt,0) -- (2pt,4pt) -- cycle;%
\end{tikzpicture}%
}

%% macro for the diminished seventh
\newcommand{\musicdim}[0]{%
\begin{tikzpicture}[]%
	\draw (0,0) circle [radius=2pt];%
\end{tikzpicture}%
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
	\textbf{#1}%
	\ifthenelse{ \equal{#3}{minor} }{%
		\ifthenelse{ \equal{#2}{sharp} }{%
			\mystack{\scriptsize}{\textbf{$\sharp$} \textbf{\tiny{m}\normalsize}}%
		}{}%
		\ifthenelse{ \equal{#2}{flat} }{%
			\mystack{\scriptsize}{\textbf{$\flat$} \textbf{\tiny{m}\normalsize}}%
		}{}%
		\ifthenelse{ \equal{#2}{} }{%
			\mystack{\tiny}{\textbf{m}}%
		}{}%
	}{%
		\ifthenelse{ \equal{#2}{sharp} }{%
			\mystack{\scriptsize}{\textbf{$\sharp$} \textbf{\phantom{\tiny{n}\normalsize}}}%
		}{}%
		\ifthenelse{ \equal{#2}{flat} }{%
			\mystack{\scriptsize}{\textbf{$\flat$}  \textbf{\phantom{\tiny{n}\normalsize}}}%
		}{}%
	}%
	\ifthenelse{ \equal{#4}{} }{}{%
		\smash{\raise 8pt\vbox{%
		\notestack{\tiny}{#4}%
		}}%
	}%
	\ifthenelse{ \equal{#5}{maj} }{%
		\smash{\raise1.5ex\hbox{\musicmaj}}%
	}{}%
	\ifthenelse{ \equal{#5}{dim} }{%
		\smash{\raise1.5ex\hbox{\musicdim}}%
	}{}%
	%\ifx&#6&%
	%\else%
	%	\smash{\lower 5pt\vbox{\moveleft 4pt\hbox{{/}}}}%
	%	\smash{\lower 9.6pt\vbox{\moveleft 3pt\hbox{{#6}}}}%
	%\fi%
}

%% does not work, seems like you can not have a stack inside anoter stack :D
\newcommand{\chordstack}[2]{%
	\mystack{}{{#1} {#2}}%
}

%% macro for one line of four bars
\newcommand{\barline}[4]{
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{ | m{127pt} | m{127pt}| m{127pt} | m{127pt} | }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}%
	\medskip
}

%% macro for one line of three bars
\newcommand{\barlinethree}[4]{
	\ifthenelse{ \equal{#1}{l} \OR \equal{#1}{left} }{%
		\raggedright
		}{
		\raggedleft
	}%
	\def\arraystretch{1.85}%
	\begin{tabular}[c]{ | m{127pt} | m{127pt} | m{127pt}  }%
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
	\begin{tabular}[c]{ | m{127pt} | m{127pt} | }%
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
	\begin{tabular}[c]{ | m{127pt} | }%
		{#2}
	\end{tabular}%
	\medskip%
}

%% macro for bar with four beats
\newcommand{\barfour}[5]{
	\begin{tabular}[c]{ m{0pt} m{28pt} m{28pt} m{28pt} m{28pt} }
		{#1} & {#2} & {#3} & {#4} & {#5}
	\end{tabular}
}

%% macro for bar with three beats
\newcommand{\barthree}[4]{
	\begin{tabular}[c]{ m{0pt} m{40pt} m{40pt} m{40pt} }
		{#1} & {#2} & {#3} & {#4}
	\end{tabular}
}

%% macro for voltas
\newcommand{\nvolta}[1]{
	\smash{\raise 34pt\vbox to 0pt {\vfil \moveleft 4pt\hbox to 0pt{
	\begin{tikzpicture}[]
		\draw (0pt,0pt) --
		(0pt,8pt) --
		(2pt,8pt) node[align=right,below,inner sep=0pt,outer sep=0pt]
			{\smash{\lower 1pt\vbox to 0pt{\vfil \hbox to 0pt{\tiny{#1}.\normalsize}}}} --
		(96pt,8pt);
	\end{tikzpicture}
	}}}%
}

%% macro for primavolta
\newcommand{\primavolta}[0]{
	\nvolta{1}
}

%% macro for secundavolta
\newcommand{\secundavolta}[0]{
	\nvolta{2}
}

%% macro for setting the composer
\newcommand{\composer}[1]{
	\newcommand\printcomposer{#1}
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

%% custom title
\renewcommand{\maketitle}[0]{
	\LARGE{\printtitle}\normalsize
	\hfill
	\smash{\raise1.5ex\hbox{\scriptsize{\printcomposer}\normalsize}}%
	\bigskip
	\bigskip
}

\endinput
