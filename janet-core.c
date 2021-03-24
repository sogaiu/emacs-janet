#include <emacs-module.h>

#include "janet.h"

int plugin_is_GPL_compatible;

int emacs_module_init(struct emacs_runtime *ert)
{
  emacs_env *env = ert->get_environment(ert);

  janet_init();
  JanetTable *jenv = janet_core_env(NULL);
  janet_dostring(jenv,
		 "(spit `made-from-janet.txt` `smile\n`)",
		 "main", NULL);

  emacs_value Qfeat = env->intern(env, "janet-core");
  emacs_value Qprovide = env->intern(env, "provide");
  emacs_value args[] = { Qfeat };
  env->funcall(env, Qprovide, 1, args);

  return 0;
}
