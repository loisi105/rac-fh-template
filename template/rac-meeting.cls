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
        \makeatletter

        \input{./template/meeting-table.tex}
        \input{./template/member-table.tex}
        \vfill
        \input{./template/external-visitors-table.tex}
    \end{titlepage}
    \pagenumbering{arabic}
}
