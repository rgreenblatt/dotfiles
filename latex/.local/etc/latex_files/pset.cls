\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pset}[2020-10-03 Problem set solution class]

\RequirePackage{kvoptions}

\DeclareStringOption{name}
\DeclareStringOption{course}
\ProcessKeyvalOptions*

\LoadClass[11pt]{article}

\RequirePackage{fullpage}
\RequirePackage[top=2cm, bottom=4.5cm, left=2.5cm, right=2.5cm]{geometry}
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,amscd}
\RequirePackage{enumerate}
\RequirePackage{fancyhdr}
\RequirePackage{mathrsfs}
\RequirePackage{graphicx}
\RequirePackage{verbatim}
\RequirePackage{bbm}
\RequirePackage{float}
\RequirePackage{mathutils}

\setlength{\parindent}{0.0in}
\setlength{\parskip}{0.05in}


\pagestyle{fancyplain}
\headheight 35pt
\lhead{\pset@name}
\chead{\textbf{\Large \pset@course}}
\rhead{\today}
\lfoot{}
\cfoot{}
\rfoot{\small\thepage}
\headsep 1.5em


% vim:set filetype=tex:
