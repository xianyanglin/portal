package org.hango.cloud.envoy.infra.virtualgateway.dto;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

/**
 * @Author zhufengwei
 * @Date 2023/5/23
 */
@Getter
@Setter
public class IngressDTO implements Serializable {
    private static final long serialVersionUID = -7088345458673670369L;
    /**
     * 名称
     */
    @JSONField(name = "Name")
    private String name;

    /**
     * 命名空间
     */
    @JSONField(name = "Namespace")
    private String namespace;


    /**
     * 所属项目id
     */
    @JSONField(name = "ProjectId")
    private Long projectId;

    /**
     * 所属项目id
     */
    @JSONField(name = "IngressRule")
    private List<IngressRuleDTO> ingressRuleDTOS;


    /**
     * 配置详细内容
     */
    @JSONField(name = "Content")
    private String content;

}