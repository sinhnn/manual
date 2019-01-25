
# Convert unicode dicionary to str dictionary
def to_str(d, nd = {}):
  for k, v in d.iteritems():
    nk = str(k.encode('utf-8'));
    if isinstance(v, dict):
      nd[nk] = {};
      to_str(v, nd[nk])
    elif isinstance(v, list):
      # nk = str(k.encode('utf-8'));
      nd[nk] = [];
      for vv in v: nd[nk].append(str(vv.encode('utf-8')));
    else: nd[nk] = str(v.encode('utf-8'));
   
