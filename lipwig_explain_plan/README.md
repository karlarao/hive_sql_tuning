
Explain plan workflow:

1) place and run the testquery.sql on the server/hive environment
2) create a json file (copy/paste) from the json output
3) generate the svg files by executing the following:
```
    sh explain <json filename>
```
4) view the svg from a web browser. there are two svg files:
```
explain_simple* file - just the simple high level node viz
explain_all_* file - are the detailed EXPLAIN_PLAN with “Alias Name”, “Access and Filter Predicates”, “Projection/Columns”
```


NOTE:
* You can use OmniGraffle to be able to drag or rearrange the nodes of the .dot files
* You can paste the contents of .dot files to http://viz-js.com/ or http://graphviz.it/#/QgMbDsZH
* You can view the json files on http://jsonviewer.stack.hu/ for drill down and exploration 
