/*
 * The MIT License (MIT)
 *
 * Copyright (c) <2014-2015> <Ioannis Moutsatsos, Bruno P. Kinoshita>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.biouno.unochoice;

import java.util.LinkedList;
import java.util.List;

import org.biouno.unochoice.model.AbstractScript;

import hudson.model.Descriptor;
import hudson.model.ParameterDefinition.ParameterDescriptor;

/**
 * Descriptor for Uno Choice parameters.
 *
 * @author Bruno P. Kinoshita
 * @since 0.20
 */
public class UnoChoiceParameterDescriptor extends ParameterDescriptor {

    public List<Descriptor<? extends AbstractScript>> getApplicableResultSeekers() {
        List<Descriptor<? extends AbstractScript>> list = new LinkedList<Descriptor<? extends AbstractScript>>();
        for (Descriptor<? extends AbstractScript> rs : AbstractScript.all()) {
            list.add(rs);
        }
        return list;
    }

}
