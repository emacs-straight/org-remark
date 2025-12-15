                         ━━━━━━━━━━━━━━━━━━━━━
                          README – ORG-REMARK
                         ━━━━━━━━━━━━━━━━━━━━━


Table of Contents
─────────────────

1. Introduction
2. Features
3. Installation
4. Contributing and Feedback
5. Contributors
6. License


1 Introduction
══════════════

  Org-remark lets you highlight and annotate text files, websites, EPUB
  books and Info documentation with using Org mode.

  A user manual is available [online] or Emacs in-system as an Info node
  `(org-remark)': (`C-h i' and find the `Org-remark' node) .

  The user manual is also available in Japanese: [マニュアル日本語版] 🇯🇵
  (translated by ayatajesi, GitHub user @ayatakesi) together with his
  review with EWW, "[org-remarkでウェブページに注釈をつける]".

  For installation and minimum configuration, refer to [Installation]
  below or the user manual: [online] or Info node `(org-remark)
  Installation'.

  Getting Started in the user manual will get you started in 5 minutes:
  [online] or or Info node `(org-remark) Getting Started'.

  For customization, refer to the customization group `org-remark' or
  user manual: [online] or Info node `(org-remark) Customizing'. A
  [separate online article] has been written to guide you on how to
  customize an icon (also part of the user manual. Evaluate (info
  "(or-gremark) How to Set Org-remark to Use SVG Icons").

  An [introductory video] (8 minutes) and [V1.1.0 release introduction]
  (12 minutes) are available on YouTube.


[online] <https://nobiot.github.io/org-remark/>

[マニュアル日本語版]
<https://qiita.com/ayatakesi/items/69d43671b28bb27a9c52>

[org-remarkでウェブページに注釈をつける]
<https://qiita.com/ayatakesi/items/8986af2bf2ccca170439>

[Installation] See section 3

[online] <https://nobiot.github.io/org-remark/#Installation>

[online] <https://nobiot.github.io/org-remark/#Getting-Started>

[online] <https://nobiot.github.io/org-remark/#Customizing>

[separate online article]
<https://github.com/nobiot/org-remark/tree/main/docs/articles/2023-08-20T184309_C_how-to-set-icons-to-be-svg-images.md>

[introductory video] <https://youtu.be/c8DHrAsFiLc>

[V1.1.0 release introduction] <https://youtu.be/BTFuS21N00k>


2 Features
══════════

  • Highlight and annotate any text file. The highlights and notes are
    kept in an Org file as the plain text database. This lets you easily
    manage your marginal notes and use the built-in Org facilities on
    them – e.g. create a sparse tree based on the category of the notes

  • Create your your own highlighter pens with different colors, type
    (e.g. underline, squiggle, etc. optionally with Org's category for
    search and filter on your highlights and notes)

  • Have the same highlighting and annotating functionality for

    ⁃ Websites when you use EWW to browse them

    ⁃ EPUB books with [nov.el]

    ⁃ Info documentation

    ⁃ [wallabag.el] (it has been [reported])

  Refer to [NEWS] file for a list of new features and fixes.


[nov.el] <https://depp.brause.cc/nov.el/>

[wallabag.el] <https://github.com/chenyanming/wallabag.el>

[reported]
<https://github.com/nobiot/org-remark/issues/92#issuecomment-2601307855>

[NEWS] <https://github.com/nobiot/org-remark/blob/main/NEWS>


3 Installation
══════════════

  This package is available on:

  • [GNU-ELPA] (releases only; equivalent to MELPA-Stable)
  • [GNU-devel ELPA] (unreleased main branch; equivalent to MELPA)

  GNU ELPA should be already set up in your Emacs by default. If you
  wish to add GNU-devel ELPA, simply add its URL to `package-archives'
  like this:

  ┌────
  │ (add-to-list 'package-archives
  │              '("gnu-devel" . "https://elpa.gnu.org/devel/") :append)
  └────

  After installation, we suggest you put the setup below in your
  configuration.

  ┌────
  │ (org-remark-global-tracking-mode +1)
  │ 
  │ ;; Optional if you would like to highlight websites via eww-mode
  │ (with-eval-after-load 'eww
  │   (org-remark-eww-mode +1))
  │ 
  │ ;; Optional if you would like to highlight EPUB books via nov.el
  │ (with-eval-after-load 'nov
  │   (org-remark-nov-mode +1))
  │ 
  │ ;; Optional if you would like to highlight Info documentation via Info-mode
  │ (with-eval-after-load 'info
  │   (org-remark-info-mode +1))
  └────

  Unless you explicitly load `org' during Emacs initialization, I
  suggest to defer loading `org-remark' (thus there is no `(require
  'org-remark)' in the example above). This is because it will also pull
  in `org', which can slow down initialization. You can control the
  timing of loading `org-remark' by autoloading some commands in a
  similar way with the example keybindings below.

  Below are example keybindings you might like to consider:

  ┌────
  │ ;; Key-bind `org-remark-mark' to global-map so that you can call it
  │ ;; globally before the library is loaded.
  │ 
  │ (define-key global-map (kbd "C-c n m") #'org-remark-mark)
  │ 
  │ ;; The rest of keybidings are done only on loading `org-remark'
  │ (with-eval-after-load 'org-remark
  │   (define-key org-remark-mode-map (kbd "C-c n o") #'org-remark-open)
  │   (define-key org-remark-mode-map (kbd "C-c n ]") #'org-remark-view-next)
  │   (define-key org-remark-mode-map (kbd "C-c n [") #'org-remark-view-prev)
  │   (define-key org-remark-mode-map (kbd "C-c n r") #'org-remark-remove)
  │   (define-key org-remark-mode-map (kbd "C-c n d") #'org-remark-delete))
  └────

  Alternatively, you can use `use-package' to set up Org-remark. The
  example provided below should be equivalent to the setup described
  above.

  ┌────
  │ (use-package org-remark-global-tracking
  │   ;; It is recommended that `org-remark-global-tracking-mode' be
  │   ;; enabled when Emacs initializes. You can set it in
  │   ;; `after-init-hook'.
  │   :hook after-init
  │   :config
  │   ;; Selectively keep or comment out the following if you want to use
  │   ;; extensions for Info-mode, EWW, and NOV.el (EPUB) respectively.
  │   (use-package org-remark-info :after info :config (org-remark-info-mode +1))
  │   (use-package org-remark-eww  :after eww  :config (org-remark-eww-mode +1))
  │   (use-package org-remark-nov  :after nov  :config (org-remark-nov-mode +1)))
  │ 
  │ (use-package org-remark
  │   :bind (;; :bind keyword also implicitly defers org-remark itself.
  │          ;; Keybindings before :map is set for global-map. Adjust the keybinds
  │          ;; as you see fit.
  │          ("C-c n m" . org-remark-mark)
  │          ("C-c n l" . org-remark-mark-line)
  │          :map org-remark-mode-map
  │          ("C-c n o" . org-remark-open)
  │          ("C-c n ]" . org-remark-view-next)
  │          ("C-c n [" . org-remark-view-prev)
  │          ("C-c n r" . org-remark-remove)
  │          ("C-c n d" . org-remark-delete)))
  └────


[GNU-ELPA] <https://elpa.gnu.org/packages/org-remark.html>

[GNU-devel ELPA] <https://elpa.gnu.org/devel/org-remark.html>


4 Contributing and Feedback
═══════════════════════════

  Create issues, discussion, and/or pull requests in the GitHub
  repository. All welcome.

  Org-remark is available on GNU ELPA and thus copyrighted by the [Free
  Software Foundation] (FSF). This means that anyone who is making a
  substantive code contribution will need to "assign the copyright for
  your contributions to the FSF so that they can be included in GNU
  Emacs" ([Org Mode website]).

  Thank you.


[Free Software Foundation] <http://fsf.org>

[Org Mode website] <https://orgmode.org/contribute.html#copyright>


5 Contributors
══════════════

  *New features*

  • User option `org-remark-report-no-highlights`by Kristoffer Balintona
    (@krisbalintona)
  • EPUB books (nov.el) support would not have been possible without
    collaboration with @sati-bodhi
  • `echo-text' update from the marginal notes to the source buffer by
    marty hiatt (@mooseyboots)
  • Support for websites with `eww-mode' by Vedang Manerikar (@vedang)

  *Bug fixes*

  Joseph Turner (@josephmturner) @alan-w-255, Nan Jun Jie (@nanjj),
  @sgati-bodhi

  *Documentation (including README, NEWS, CHANGELOG)*

  @randomwangran, marty hiatt (@mooseyboots), @jsntn

  Thank-you to all the comments, issues, and questions on GitHub!


6 License
═════════

  This work is licensed under a GPLv3 license. For a full copy of the
  license, refer to [LICENSE].


[LICENSE] <./LICENSE>
