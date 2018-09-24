from powerline_shell.utils import BasicSegment
from kubernetes import K8sConfig

class Segment(BasicSegment):

    def add_to_powerline(self):
        try:
            context = K8sConfig().current_context
        except Exception as e:
            pl.error(e)
            return

        #return self.build_segments(context, namespace)
        #self.powerline.append(self.build_segments(context, namespace),
        self.powerline.append(u'\U00002388 ' + context,
            self.powerline.theme.AWS_PROFILE_FG,
            self.powerline.theme.AWS_PROFILE_BG)

