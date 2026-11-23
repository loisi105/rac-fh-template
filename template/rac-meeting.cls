\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template/rac-meeting}[2026/02/06 Class for RAC Meeting]

\LoadClass[11pt, a4paper]{article}

% Directory of the template files (logo, table snippets).
% Override before \documentclass with \def\racdir{path} if needed.
\providecommand*{\racdir}{template}

\RequirePackage[ngerman]{babel}
\RequirePackage[table]{xcolor}
\RequirePackage[top=4cm, bottom=4cm, left=4cm, right=4cm, headsep=1cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{adjustbox}
\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{etoolbox}
\RequirePackage{xltabular}
\RequirePackage{tabularx}
\RequirePackage{amssymb}
\RequirePackage{csvsimple-l3}
\RequirePackage{graphicx}
\RequirePackage[ngerman]{datetime2}
\RequirePackage[hidelinks]{hyperref}

\definecolor{rac-table-row}{gray}{0.95}
\definecolor{rac-table-header}{gray}{0.85}
\definecolor{rac-pink}{HTML}{c10042}

% Translatable strings
\newcommand*{\racAuthorLabel}{Autor}
\newcommand*{\racPageLabel}{Seite}
\newcommand*{\racNoTodos}{Keine ToDos.}

\newcommand*{\racMeetingTitle}{}
\newcommand*{\racMeetingAuthor}{}
\newcommand*{\racMeetingLocation}{}
\newcommand*{\racMeetingStart}{}
\newcommand*{\racMeetingEnd}{}
\DTMsavedate{racmeetingdate}{\the\year-\two@digits\month-\two@digits\day}
\newcommand*{\racMeetingDate}{\DTMusedate{racmeetingdate}}

\newcommand{\mTitle}[1]{\renewcommand*{\racMeetingTitle}{#1}}
\newcommand{\mAuthor}[1]{\renewcommand*{\racMeetingAuthor}{#1}}
\newcommand{\mLocation}[1]{\renewcommand*{\racMeetingLocation}{#1}}
\newcommand{\mStart}[1]{\renewcommand*{\racMeetingStart}{#1}}
\newcommand{\mEnd}[1]{\renewcommand*{\racMeetingEnd}{#1}}
% Date in ISO format: \mDate{2026-01-20}, printed as 20.01.2026
\newcommand{\mDate}[1]{\DTMsavedate{racmeetingdate}{#1}}

% \racIfYes{value}{true}{false}: value is 1, x or ja (case-insensitive, spaces trimmed)
\ExplSyntaxOn
\NewDocumentCommand{\racIfYes}{m m m}
  {
    \str_case:enF { \str_lowercase:f { \tl_trim_spaces:n {#1} } }
      { {1}{#2} {x}{#2} {ja}{#2} }
      {#3}
  }
\ExplSyntaxOff

\pagestyle{fancy}
\fancyhf{}

\fancyhead[L]{\racMeetingTitle\ - \racMeetingDate}
\fancyhead[R]{  \adjustimage{width=0.4\linewidth, valign=m}{\racdir/RAC_FH_Clublogo.png}}
\fancyfoot[L]{\racAuthorLabel: \racMeetingAuthor}
\fancyfoot[R]{\racPageLabel{} \thepage/\pageref*{LastPage}}

\setlength{\headheight}{50pt}
\setlength{\footskip}{37pt}


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


\newcommand{\makeRacTitle}{
    \pagenumbering{gobble}
    \begin{titlepage}
        \begin{textblock}{5}(7.5, 0.5)
            \includegraphics[width=\linewidth]{\racdir/RAC_FH_Clublogo.png}
        \end{textblock}

        \centering
        {\Huge \bfseries \color{rac-pink} \racMeetingTitle} \\[0.4cm]

        \input{\racdir/meeting-table.tex}
        \input{\racdir/member-table.tex}
        \vfill
        \input{\racdir/external-visitors-table.tex}
    \end{titlepage}
    \pagenumbering{arabic}
}

% Usage: \todo[deadline]{Who}{What}   (deadline is optional)

\newcommand*\@todorows{}
\newcommand*\@todorowsdl{}
\newtoggle{todohasdeadline}
\newcounter{todoitem}

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
    {\emph{\racNoTodos}}
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
