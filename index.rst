.. Our new car documentation master file, created by
   sphinx-quickstart on Tue Jun  3 19:25:23 2025.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

Our new car documentation
=========================

Add your content using ``reStructuredText`` syntax. See the
`reStructuredText <https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html>`_
documentation for details.

.. needlist::

.. needtable::

.. req:: First need example
   :id: REQ_1

   A basic example of a requirement.

.. req:: Second need example
   :id: REQ_2
   :required_by: REQ_1

   A second example of a requirement.

.. needservice:: github-issues
   :query: repo:useblocks/sphinx-needs node latexpdf
   :max_content_lines: 4
   :id_prefix: EXAMPLE_
