\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template/rac-meeting}[2026/02/06 Class for RAC Meeting]

\LoadClass[11pt, a4paper]{article}

\RequirePackage[top=4cm, bottom=4cm, left=4cm, right=4cm, headsep=1cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{adjustbox}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{etoolbox}
\RequirePackage{xltabular}

% global Variable definitions
\newcommand{\mTitle}[1]{\def\@mTitle{#1}}
\newcommand{\mDate}[1]{\def\@mDate{#1}}
\newcommand{\mAuthor}[1]{\def\@mAuthor{#1}}
\newcommand{\mLocation}[1]{\def\@mLocation{#1}}
\newcommand{\mStart}[1]{\def\@mStart{#1}}
\newcommand{\mEnd}[1]{\def\@mEnd{#1}}

% Header and Footer layout
\pagestyle{fancy}
\fancyhf{}

\fancyhead[L]{\@mTitle \ - \@mDate}
\fancyhead[R]{  \adjustimage{width=0.4\linewidth, valign=m}{template/RAC_FH_Clublogo.png}}
\fancyfoot[L]{Autor: \@mAuthor}
\fancyfoot[R]{Seite \thepage/\pageref*{LastPage}}

\setlength{\headheight}{50pt}
\setlength{\footskip}{37pt}

% Styling of headers

\titleformat{\section}
{\normalfont\Large\bfseries\color{rac-pink}}
{\thesection.}
{1em}
{}

\titleformat{\subsection}
{\normalfont\large\bfseries\color{rac-pink}}
{\thesubsection}
{1em}
{}

\titleformat{\subsubsection}
{\normalfont\bfseries\color{rac-pink}}
{\thesubsubsection}
{1em}
{}

% Title page

\newcommand{\makeRacTitle}{
    \pagenumbering{Alph} % prevent duplicate page 1 even tough never output0
    \begin{titlepage}
        \begin{textblock}{5}(7.5, 0.5)
            \includegraphics[width=\linewidth]{./template/RAC_FH_Clublogo.png}
        \end{textblock}

        \centering
        \makeatletter
        {\Huge \bfseries \color{rac-pink} \@mTitle} \\[0.4cm]

        \input{./template/meeting-table.tex}
        \input{./template/member-table.tex}
        \vfill
        \input{./template/external-visitors-table.tex}
    \end{titlepage}
    \pagenumbering{arabic}
}

% Usage: \todo[deadline]{Who}{What}   (deadline is optional)
% The "Bis wann" column is only printed if at least one todo has a deadline,
% so every row is stored twice: with and without that column.
% Requires hyperref (loaded in preamble.sty): the "Abschnitt" entry links to the todo itself.

\newcommand*\@todorows{}
\newcommand*\@todorowsdl{}
\newtoggle{todohasdeadline}
\newcounter{todoitem}

% Current position: subsection if inside one, else section
\newcommand*\@todoloc{\ifnum\value{subsection}>0 \thesubsection\else\thesection\fi}

\NewDocumentCommand{\todo}{o m m}{%
  \stepcounter{todoitem}%
  \hypertarget{todo.\thetodoitem}{\textbf{$\rightarrow$ #2:}}~\emph{#3}%
  \IfValueT{#1}{\ (bis #1)\global\toggletrue{todohasdeadline}}%
  \xappto\@todorows{%
    \unexpanded{#2} & \unexpanded{#3} &
    \noexpand\hyperlink{todo.\thetodoitem}{\@todoloc}
    \noexpand\\ \noexpand\hline}%
  \xappto\@todorowsdl{%
    \unexpanded{#2} & \unexpanded{#3} &
    \IfValueTF{#1}{\unexpanded{#1}}{--} &
    \noexpand\hyperlink{todo.\thetodoitem}{\@todoloc}
    \noexpand\\ \noexpand\hline}%
}

\newcommand{\printtodos}{%
  \section*{ToDo}
  \ifdefempty{\@todorows}
    {\emph{Keine ToDos.}}
    {\iftoggle{todohasdeadline}
      {\begin{xltabular}{\textwidth}{|l|X|l|c|}
        \hline
        \textbf{Wer} & \textbf{Was} & \textbf{Bis wann} & \textbf{Abschnitt} \\ \hline
        \endhead
        \@todorowsdl
      \end{xltabular}}
      {\begin{xltabular}{\textwidth}{|l|X|c|}
        \hline
        \textbf{Wer} & \textbf{Was} & \textbf{Abschnitt} \\ \hline
        \endhead
        \@todorows
      \end{xltabular}}}%
}
